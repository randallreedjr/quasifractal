class Printer
  attr_reader :quasifractal
  def initialize(quasifractal)
    @quasifractal = quasifractal
  end

  def to_html
    output = ""
    output << "<html>"
    output << "<head>#{style}</head>"
    output << "<body>"
    output << array_to_html(quasifractal.board, 9)
    output << "</body></html>"
    return output
  end

  def to_html_file(filename = "index.html")
    File.open(filename, "w+") do |file|
      file.write "<html>"
      file.write "<head>#{style}</head>"
      file.write "<body>"
      file.write array_to_html(quasifractal.board, 9)
      file.write "</body></html>"
    end
  end

  private

  def array_to_html(array, border_width)
    content = "<table>"

    array.each.with_index do |el, index|
      if index % 3 == 0
        content += "<tr>"
      end

      # vertical borders: l(eft), m(iddle), r(ight)
      border_styles = []
      if index % 3 == 0
        border_styles << "l#{border_width}"
      elsif index %3 == 1
        border_styles << "m#{border_width}"
      elsif index % 3 == 2
        border_styles << "r#{border_width}"
      end

      # horizontal borders: t(op), c(enter), b(ottom)
      if index / 3 == 0
        border_styles << "t#{border_width}"
      elsif index / 3 == 1
        border_styles << "c#{border_width}"
      elsif index / 3 == 2
        border_styles << "b#{border_width}"
      end

      content += "<td class=\"#{border_styles.join(' ')}\">"

      if el.is_a? Array
        content += array_to_html(el, border_width - 1)
      elsif el.nil?
        content += "&nbsp;&nbsp;"
      else
        content += "<span class=\"s#{border_width + 1}\">#{el}</span>"
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
        ".t#{size} { border-bottom: #{size}px solid black; padding-bottom: #{size}px; }",
        ".b#{size} { border-top: #{size}px solid black; padding-top: #{size}px; }",
        ".l#{size} { border-right: #{size}px solid black; padding-right: #{size}px; }",
        ".r#{size} { border-left: #{size}px solid black; padding-left: #{size}px; }",
        # ".s#{size} { font-size: #{(9*size)}pt; }"
        # Size for 5th move board
        ".s#{size} { font-size: #{(9*(size-4))}pt; }"
      ]
    end.join("\n")
    style += "\n</style>"
    return style
  end
end
