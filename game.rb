class Game
  attr_reader :board
  def initialize(board)
    @board = board.dup
  end

  def game_over?
    return false if board.compact.length < 5
    return true if board.compact.length == 9
    !!winner
  end

  def winner
    return nil if board.compact.length < 5
    winning_mark = winning_column || winning_row || winning_diagonal
    return 'C' if winning_mark.nil? && board.compact.length == 9
    winning_mark
  end

  private

  def winning_column
    first_column = board[0].nil? ? nil : (board[0] if (board[0] == board[3]) && (board[3] == board[6]))
    second_column = board[1].nil? ? nil : (board[1] if (board[1] == board[4]) && (board[4] == board[7]))
    third_column = board[2].nil? ? nil : (board[2] if (board[2] == board[5]) && (board[5] == board[8]))
    first_column || second_column || third_column
  end

  def winning_row
    first_row = board[0].nil? ? nil : (board[0] if (board[0] == board[1]) && (board[1] == board[2]))
    second_row = board[3].nil? ? nil : (board[3] if (board[3] == board[4]) && (board[4] == board[5]))
    third_row = board[6].nil? ? nil : (board[6] if (board[6] == board[7]) && (board[7] == board[8]))
    first_row || second_row || third_row
  end

  def winning_diagonal
    first_diagonal = board[0].nil? ? nil : (board[0] if (board[0] == board[4]) && (board[4] == board[8]))
    second_diagonal = board[2].nil? ? nil : (board[2] if (board[2] == board[4]) && (board[4] == board[6]))
    first_diagonal || second_diagonal
  end
end
