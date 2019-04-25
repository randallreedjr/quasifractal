class GameTree
  attr_reader :board
  def initialize(board)
    @board = board.dup
  end

  def minmax(mark: nil)
    board.map do |move|
      # Need to add a test for leaf nodes and add recursion
      if move.is_a? Array
        value(board: move, mark: mark)
      else
        move
      end
    end
  end

  def value(board: @board, mark: nil)
    game = Game.new(board)

    return 0 unless game.game_over?
    return 0 if game.winner == 'C'
    mark == game.winner ? 1 : -1
  end
end
