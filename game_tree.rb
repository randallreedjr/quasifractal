class GameTree
  def minimax(board:, mark: nil, minimax: nil)
    return board if board.is_a?(String) && board.length == 1
    return value(board: board, mark: mark) if leaf?(board: board)

    board.map! do |move|
      minimax(board: move, mark: mark, minimax: true)
    end

    if minimax.nil?
      # For outermost board, return an array;
      # don't condense to a single value
      return board
    else
      return board.select {|el| el.is_a? Numeric}.max
    end
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
