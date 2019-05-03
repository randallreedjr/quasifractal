class Quasifractal
  attr_reader :board
  def initialize(board = empty_board)
    @board = board
  end

  def nth_move!(n, board = self.board)
    return board if n == 0 || !(board.is_a? Array)
    return board if Game.new(board).game_over?

    # What next? How do we get to the bottom of an arbitratily deeply nested array
    # What if we convert to a hash, where the key is the level of nesting?
    # Maybe an array isn't the right approach?

    # Depth first search?
    # How to determine depth
    #make a move
    old_board = board.dup
    board.map!.with_index do |new_board, index|
      if new_board.nil?
        new_board = old_board.dup
        # need to adjust index based on position of existing move
        position = index
        until new_board[index].nil?
          position += 1
        end
        new_board[position] = mark(old_board)
      end
      new_board
    end
    board.map! do |new_board|
      nth_move!(n - 1, new_board)
    end
    @board = board
    return board
  end

  # def depth
  #   level_count = 0
  #   current_level = board
  #   while current_level.any? {|el| el.is_a? Array}
  #     current_level = current_level.detect {|el| el.is_a? Array}
  #     level_count += 1
  #   end
  #   level_count
  # end

  def mark(board)
    board.count(nil).odd? ? 'X' : 'O'
  end

  private

  def empty_board
    Array.new(9, nil)
  end
end
