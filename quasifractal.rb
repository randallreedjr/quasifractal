class Quasifractal
  attr_reader :board
  def initialize
    @board = empty_board
  end

  def empty_board
    Array.new(9, nil)
  end

  def first_move
    # should this mutate?
    @board = empty_board
    @board.map.with_index do |new_board, index|
      new_board = @board.dup
      new_board[index] = 'X'
      new_board
    end
  end

  def second_move
    @board = first_move
    @board.map do |first_move_board|
      first_move_board.map.with_index do |new_board, index|
        # Skip if a move has already been made
        if new_board.nil?
          new_board = first_move_board.dup
          new_board[index] = 'O'
        end
        new_board
      end
    end
  end

  def nth_move(n)
    return empty_board if n == 0
    # What next? How do we get to the bottom of an arbitratily deeply nested array
    # What if we convert to a hash, where the key is the level of nesting?
    # Maybe an array isn't the right approach?

    # Depth first search?
  end
end
