describe Quasifractal do
  describe '#initialize' do
    it 'sets board to an empty board' do
      board = Quasifractal.new.board

      expect(board.is_a?(Array)).to be true
      expect(board.length).to eq 9
      expect(board.compact.length).to eq 0
    end
  end

  describe '#empty_board' do
    it 'returns an array representing an empty board' do
      board = Quasifractal.new.empty_board

      expect(board.is_a?(Array)).to be true
      expect(board.length).to eq 9
      expect(board.compact.length).to eq 0
    end
  end

  describe 'nth move' do
    context 'when n is 0' do
      it 'returns an empty board' do
        board = Quasifractal.new.nth_move!(0)
        empty_board = Quasifractal.new.empty_board

        expect(board).to eq empty_board
      end
    end

    context 'when n is 1' do
      it 'returns a nested array' do
        board = Quasifractal.new.nth_move!(1)

        expect(board.is_a?(Array)).to be true
        expect(board[0].is_a?(Array)).to be true
      end

      it 'returns an array containing 9 arrays' do
        board = Quasifractal.new.nth_move!(1)

        expect(board.length).to eq 9
        expect(board.compact.length).to eq 9
      end

      it 'returns an array with 9 moves made' do
        board = Quasifractal.new.nth_move!(1)

        # 9 containers
          # 1 (first move), 8 a
        # 9*(1 + 8*(2 + 7))
        expect(board.flatten.length).to be 81
        expect(board.flatten.compact.length).to be 9
      end

      it 'fills all first moves with X' do
        board = Quasifractal.new.nth_move!(1)

        expect(board[0][0]).to eq 'X'
        expect(board[1][1]).to eq 'X'
        expect(board[2][2]).to eq 'X'
        expect(board[3][3]).to eq 'X'
        expect(board[4][4]).to eq 'X'
        expect(board[5][5]).to eq 'X'
        expect(board[6][6]).to eq 'X'
        expect(board[7][7]).to eq 'X'
        expect(board[8][8]).to eq 'X'
      end
    end

    context 'when n is 2' do
      it 'returns a partially nested array' do
        board = Quasifractal.new.nth_move!(2)

        expect(board.is_a?(Array)).to be true
        expect(board[0].is_a?(Array)).to be true
        expect(board[0][0].is_a?(Array)).to be false
        expect(board[0][1].is_a?(Array)).to be true
      end

      it 'returns an array containing 9 arrays' do
        board = Quasifractal.new.nth_move!(2)

        expect(board.length).to eq 9
        expect(board.compact.length).to eq 9
      end

      it 'returns an array with 657 moves made' do
        board = Quasifractal.new.nth_move!(2)

        # 9 containers
          # 1 (first move), 8 arrays
            # 2 (first and second move) + 7 nil
        # 9*(1 + 8*(2 + 7))
        expect(board.flatten.length).to be 657
        # 9*(1 + 8*(2))
        expect(board.flatten.compact.length).to be 153
      end

      it 'returns an array with the second moves made' do
        board = Quasifractal.new.nth_move!(2)

        expect(board[0][1][1]).to eq 'O'
        expect(board[0][2][2]).to eq 'O'
        expect(board[0][3][3]).to eq 'O'
        expect(board[0][4][4]).to eq 'O'
        expect(board[0][5][5]).to eq 'O'
        expect(board[0][6][6]).to eq 'O'
        expect(board[0][7][7]).to eq 'O'
        expect(board[0][8][8]).to eq 'O'
      end
    end

    context 'when n is 3' do
      it 'returns a partially nested array' do
        board = Quasifractal.new.nth_move!(3)

        expect(board.is_a?(Array)).to be true
        expect(board[0].is_a?(Array)).to be true
        expect(board[0][0].is_a?(Array)).to be false
        expect(board[0][1].is_a?(Array)).to be true
      end

      it 'returns an array containing 9 arrays' do
        board = Quasifractal.new.nth_move!(3)

        expect(board.length).to eq 9
        expect(board.compact.length).to eq 9
      end

      it 'returns an array with 72 moves made' do
        board = Quasifractal.new.nth_move!(3)

        # 9 containers
          # 1 (first move), 8 arrays
            # 2 (first and second move), 7 arrays
              # 3 (first, second, third move) + 6 nil
        # 9*(1 + 8*(2 + 7*9))
        expect(board.flatten.length).to be 4689
        # 9*(1 + 8*(2 + 7*3))
        expect(board.flatten.compact.length).to be 1665
      end

      it 'returns an array with the second moves made' do
        board = Quasifractal.new.nth_move!(3)

        expect(board[0][1][1]).to eq 'O'
        expect(board[0][2][2]).to eq 'O'
        expect(board[0][3][3]).to eq 'O'
        expect(board[0][4][4]).to eq 'O'
        expect(board[0][5][5]).to eq 'O'
        expect(board[0][6][6]).to eq 'O'
        expect(board[0][7][7]).to eq 'O'
        expect(board[0][8][8]).to eq 'O'
      end
    end
  end

  describe 'game_over?' do
    it 'returns false for an empty board' do
      quasifractal = Quasifractal.new
      board = quasifractal.empty_board

      expect(quasifractal.game_over?(board)).to be false
    end

    it 'retuns false for a board that is not complete' do
      quasifractal = Quasifractal.new
      board = ['X','O','X','O','X', nil, nil, nil, nil]

      expect(quasifractal.game_over?(board)).to be false
    end

    it 'retuns true for an incomplete board where X has won' do
      quasifractal = Quasifractal.new
      board = ['X','X','X','O','O', nil, nil, nil, nil]

      expect(quasifractal.game_over?(board)).to be true
    end

    it 'retuns true for an complete board where X has won' do
      quasifractal = Quasifractal.new
      board = ['X', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'O']

      expect(quasifractal.game_over?(board)).to be true
    end

    it 'retuns true for an incomplete board where O has won' do
      quasifractal = Quasifractal.new
      board = ['X','X','O','X','O', nil, 'O', nil, nil]

      expect(quasifractal.game_over?(board)).to be true
    end

    it 'retuns true for an complete board where no one has won' do
      quasifractal = Quasifractal.new
      board = ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X']

      expect(quasifractal.game_over?(board)).to be true
    end
  end

  describe 'to_html' do
    it 'prints a first-move board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(1)

      quasifractal.to_html
    end

    it 'prints a second-move board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(2)

      quasifractal.to_html
    end

    it 'prints a third-move board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(3)

      quasifractal.to_html
    end

    xit 'prints a full board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(6)

      quasifractal.to_html_file
    end
  end
end
