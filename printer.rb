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

      border_styles = []
      if index % 3 == 0
        border_styles << "lc-#{border_width}"
      elsif index % 3 == 2
        border_styles << "rc-#{border_width}"
      end

      if index / 3 == 0
        border_styles << "tr-#{border_width}"
      elsif index / 3 == 2
        border_styles << "br-#{border_width}"
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
        ".tr-#{size} { border-bottom: #{size}px solid black; padding-bottom: #{size}px; }",
        ".br-#{size} { border-top: #{size}px solid black; padding-top: #{size}px; }",
        ".lc-#{size} { border-right: #{size}px solid black; padding-right: #{size}px; }",
        ".rc-#{size} { border-left: #{size}px solid black; padding-left: #{size}px; }",
        ".size-#{size} { font-size: #{(9*size)}px; }"
      ]
    end.join("\n")
    style += "\n</style>"
    return style
  end
end
