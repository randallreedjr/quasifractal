describe Printer do
  let(:printer) { Printer.new(quasifractal) }
  let(:quasifractal) { Quasifractal.new }

  describe 'to_html' do
    it 'returns an html string' do
      output = printer.to_html

      # String is too long to match entire thing in one match data
      expect(!!output.match(/\A<html>/)).to be true
      expect(!!output.match(/<\/html>\z/)).to be true
    end

    context 'for a first-move quasifractal' do
      it 'prints a first-move board' do
        quasifractal.nth_move!(1)
        move_regex = /<span class=\"size-[0-9]\">X<\/span>/
        output = printer.to_html

        expect(output.scan(move_regex).count).to eq 9
      end
    end

    context 'for a second-move quasifractal' do
      it 'prints a second-move board' do
        quasifractal.nth_move!(2)
        x_move_regex = /<span class=\"size-[0-9]\">X<\/span>/
        o_move_regex = /<span class=\"size-[0-9]\">O<\/span>/
        output = printer.to_html

        # 9 first moves + 9 * 8 second moves
        expect(output.scan(x_move_regex).count).to eq 81
        # 9 * 8 second moves
        expect(output.scan(o_move_regex).count).to eq 72
      end
    end

    context 'for a third-move quasifractal' do
      it 'prints a third-move board' do
        quasifractal.nth_move!(3)
        x_move_regex = /<span class=\"size-[0-9]\">X<\/span>/
        o_move_regex = /<span class=\"size-[0-9]\">O<\/span>/
        output = printer.to_html

        # 9 first moves + 9 * 8 second moves + 2 * (9 * 8 * 7) third moves
        # 9 * (1 + 8 + 112) = 9 * 121 = 1089
        expect(output.scan(x_move_regex).count).to eq 1089
        # 9 * 8 second moves + 9 * 8 * 7 third moves
        # 9 * (8 + 56) = 9 * 64 = 576
        expect(output.scan(o_move_regex).count).to eq 576
      end
    end
  end

  describe 'to_html_file' do
    xit 'prints a full board' do
      quasifractal.nth_move!(9)

      printer.to_html_file
    end
  end
end
