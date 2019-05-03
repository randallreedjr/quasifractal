class GameTree
  attr_reader :starting_board
  def initialize(starting_board = Array.new(9, nil))
    @starting_board = starting_board
    remaining_moves = starting_board.count(nil)
  end

  def next_move
    moves = minimax
    max = moves.select {|el| el.is_a? Numeric}.max
    moves.map.with_index {|move, index| move == max ? index : nil}.compact.sample
  end

  # first mark is based on how many moves are left
  # if there are an odd number of characters - O is next
  # if there are an even number of characters - X is next
  def minimax(board: self.starting_board, mark: nil, minimax: nil, min_or_max: nil)
    return board if single_move?(board)

    mark = determine_mark(board) if mark.nil?
    # Swap min_or_max each level
    min_or_max = (min_or_max == :max ? :min : :max)

    if remaining_moves(board) > 0
      board = Quasifractal.new(board).nth_move!(remaining_moves(board))
    end

    return value(board: board, mark: mark) if leaf?(board: board)

    board.map! do |move|
      minimax(board: move, mark: mark, minimax: true, min_or_max: min_or_max)
    end

    if minimax.nil?
      # For outermost board, return an array;
      # don't condense to a single value
      return board
    else
      return (board.select {|el| el.is_a? Numeric}).send(min_or_max)
    end
  end

  def single_move?(board)
    board.is_a?(String) && board.length == 1
  end

  def remaining_moves(board)
    board.count(nil)
  end

  def determine_mark(board)
    remaining_moves(board).odd? ? 'X' : 'O'
  end

  def leaf?(board:)
    board.none? {|el| el.is_a? Array}
  end

  def value(board: board, mark: nil)
    game = Game.new(board)

    return 0 unless game.game_over?
    return 0 if game.winner == 'C'
    mark == game.winner ? 1 : -1
  end

  def other_mark(mark)
    mark == 'X' ? 'O' : 'X'
  end
end
