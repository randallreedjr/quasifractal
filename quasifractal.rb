class Quasifractal
  attr_reader :board
  def initialize
    @board = empty_board
  end

  def empty_board
    Array.new(9, nil)
  end

  def nth_move!(n, board = empty_board)
    return board if n == 0
    return board unless board.is_a? Array
    return board if game_over?(board)
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

  def game_over?(board)
    return false if board.compact.length < 5
    return true if board.compact.length == 9
    winning_column?(board) || winning_row?(board) || winning_diagonal?(board)
  end

  def winning_column?(board)
    first_column = (!board[0].nil? && (board[0] == board[3]) && (board[3] == board[6]))
    second_column = (!board[1].nil? && (board[1] == board[4]) && (board[4] == board[7]))
    third_column = (!board[2].nil? && (board[2] == board[5]) && (board[5] == board[8]))
    first_column || second_column || third_column
  end

  def winning_row?(board)
    first_row = (!board[0].nil? && (board[0] == board[1]) && (board[1] == board[2]))
    second_row = (!board[3].nil? && (board[3] == board[4]) && (board[4] == board[5]))
    third_row = (!board[6].nil? && (board[6] == board[7]) && (board[7] == board[8]))
    first_row || second_row || third_row
  end

  def winning_diagonal?(board)
    first_diagonal = (!board[0].nil? && (board[0] == board[4]) && (board[4] == board[8]))
    second_diagonal = (!board[2].nil? && (board[2] == board[4]) && (board[4] == board[6]))
    first_diagonal || second_diagonal
  end

  def to_html
    puts "<html>"
    puts "<head>#{style}</head>"
    puts "<body>"
    puts array_to_html(board, 9)
    puts "</body></html>"
  end

  def to_html_file
    File.open("testfull.html", "w+") do |file|
      file.write "<html>"
      file.write "<head>#{style}</head>"
      file.write "<body>"
      file.write array_to_html(board, 9)
      file.write "</body></html>"
    end
  end

  def array_to_html(array, border_width)
    content = "<table>"

    array.each.with_index do |el, index|
      if index % 3 == 0
        content += "<tr>"
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

      content += "<td class=\"#{border_styles.join(' ')}\">"

      if el.is_a? Array
        content += array_to_html(el, border_width - 1)
      elsif el.nil?
        content += "&nbsp;&nbsp;"
      else
        content += "<span class=\"size-#{border_width + 1}\">#{el}</span>"
      end

      content += "</td>"

      if index % 3 == 2
        content += "</tr>"
      end
    end

    content += "</table>"
  end

  def style
    style = "<style>\n"
    style += "td { text-align: center; }\n"
    style += (1..9).flat_map do |size|
      [
        ".top-row-#{size} { border-bottom: #{size}px solid black; padding-bottom: #{size}px; }",
        ".bottom-row-#{size} { border-top: #{size}px solid black; padding-top: #{size}px; }",
        ".left-column-#{size} { border-right: #{size}px solid black; padding-right: #{size}px; }",
        ".right-column-#{size} { border-left: #{size}px solid black; padding-left: #{size}px; }",
        ".size-#{size} { font-size: #{(9*size)}px; }"
      ]
    end.join("\n")
    style += "\n</style>"
    return style
  end
end
