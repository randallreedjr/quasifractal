class GameTree
  attr_reader :board
  def initialize(board)
    @board = board.dup
  end

  def minmax

  end

  def value(mark = nil)
    game = Game.new(board)

    return 0 unless game.game_over?
    return 0 if game.winner == 'C'
    mark == game.winner ? 1 : -1
  end
end
