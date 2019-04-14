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

  def first_move!
    # should this mutate?
    @board = empty_board
    @board.map!.with_index do |new_board, index|
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

  def second_move!
    first_move!
    @board.map! do |first_move_board|
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

  def third_move!
    second_move!
    @board.map! do |first_move_board|
      first_move_board.map.with_index do |second_move_board|
        next unless second_move_board.is_a? Array
        second_move_board.map.with_index do |new_board, index|
          if new_board.nil?
            new_board = second_move_board.dup
            new_board[index] = 'X'
          end
          new_board
        end
      end
    end
  end

  def nth_move!(n, board = empty_board)
    return board if n == 0
    return board unless board.is_a? Array
    # What next? How do we get to the bottom of an arbitratily deeply nested array
    # What if we convert to a hash, where the key is the level of nesting?
    # Maybe an array isn't the right approach?

    # Depth first search?
    # How to determine depth
    #make a move
    old_board = board.dup
    # binding.pry if board == 'X'
    board.map!.with_index do |new_board, index|
      if new_board.nil?
        new_board = old_board.dup
        # new_board[index] = mark(old_board)
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
      # binding.pry
      nth_move!(n - 1, new_board)
    end
    @board = board
    return board
  end

  def depth
    level_count = 0
    current_level = board
    while current_level.any? {|el| el.is_a? Array}
      current_level = current_level.detect {|el| el.is_a? Array}
      level_count += 1
    end
    level_count
  end

  def mark(board)
    board.count(nil).odd? ? 'X' : 'O'
    # depth.even? ? 'X' : 'O'
  end

  def to_html
    puts "<html>"
    puts "<head>#{style}</head>"
    puts "<body>"
    # puts "<table>"
    array_to_html(board, 9)
    # puts "</table>"
    puts "</body></html>"
  end

  def array_to_html(array, border_width)
    puts "<table>"

    array.each.with_index do |el, index|
      if index % 3 == 0
        puts "<tr>"
      end

      border_styles = []
      if index % 3 == 0
        border_styles << "left-column-#{border_width}"
      elsif index % 3 == 2
        border_styles << "right-column-#{border_width}"
      end

      if index / 3 == 0
        border_styles << "top-row-#{border_width}"
      elsif index / 3 == 2
        border_styles << "bottom-row-#{border_width}"
      end

      puts "<td class=\"#{border_styles.join(' ')}\">"

      if el.is_a? Array
        array_to_html(el, border_width - 1)
      elsif el.nil?
        puts "&nbsp;"
      else
        puts "#{el}"
      end

      puts "</td>"

      if index % 3 == 2
        puts "</tr>"
      end
    end

    puts "</table>"
  end

  def style
    style = "<style>\n"
    style += "td { text-align: center; }\n"
    style += (1..9).flat_map do |size|
      [
        ".top-row-#{size} { border-bottom: #{size}px solid black; padding-bottom: #{size}px; }",
        ".bottom-row-#{size} { border-top: #{size}px solid black; padding-top: #{size}px; }",
        ".left-column-#{size} { border-right: #{size}px solid black; padding-right: #{size}px; }",
        ".right-column-#{size} { border-left: #{size}px solid black; padding-left: #{size}px; }"
      ]
    end.join("\n")
    style += "\n</style>"
    return style
  end
end
