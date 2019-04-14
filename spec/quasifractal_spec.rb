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

  fdescribe '#first_move' do
    it 'returns a nested array' do
      board = Quasifractal.new.first_move

      expect(board.is_a?(Array)).to be true
      expect(board[0].is_a?(Array)).to be true
    end

    it 'returns an array containing 9 arrays' do
      board = Quasifractal.new.first_move

      expect(board.length).to eq 9
      expect(board.compact.length).to eq 9
    end

    it 'returns an array with 9 moves made' do
      board = Quasifractal.new.first_move

      expect(board.flatten.length).to be 81
      expect(board.flatten.compact.length).to be 9
    end

    it 'fills all first moves with X' do
      board = Quasifractal.new.first_move

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

  xdescribe '#third_move' do
    it 'returns a partially nested array' do
      board = Quasifractal.new.third_move!
      binding.pry

      expect(board.is_a?(Array)).to be true
      expect(board[0].is_a?(Array)).to be true
      expect(board[0][0].is_a?(Array)).to be false
      expect(board[0][1].is_a?(Array)).to be true
      expect(board[0][1][0].is_a?(Array)).to be false
    end

    it 'returns an array containing 9 arrays' do
      board = Quasifractal.new.second_move

      expect(board.length).to eq 9
      expect(board.compact.length).to eq 9
    end

    it 'returns an array with 72 moves made' do
      board = Quasifractal.new.second_move

      # 9 + 9*(9*8) => 9 first moves, 72 second moves for each first moves
      expect(board.flatten.length).to be 657
      # 9 + 2*72 => 9 first moves (1 char), 72 second moves (2 char)
      expect(board.flatten.compact.length).to be 153
    end

    it 'returns an array with the second moves made' do
      board = Quasifractal.new.second_move

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

  describe '#second_move' do
    it 'returns a partially nested array' do
      board = Quasifractal.new.second_move

      expect(board.is_a?(Array)).to be true
      expect(board[0].is_a?(Array)).to be true
      expect(board[0][0].is_a?(Array)).to be false
      expect(board[0][1].is_a?(Array)).to be true
    end

    it 'returns an array containing 9 arrays' do
      board = Quasifractal.new.second_move

      expect(board.length).to eq 9
      expect(board.compact.length).to eq 9
    end

    it 'returns an array with 72 moves made' do
      board = Quasifractal.new.second_move

      # 9 + 9*(9*8) => 9 first moves, 72 second moves for each first moves
      expect(board.flatten.length).to be 657
      # 9 + 2*72 => 9 first moves (1 char), 72 second moves (2 char)
      expect(board.flatten.compact.length).to be 153
    end

    it 'returns an array with the second moves made' do
      board = Quasifractal.new.second_move

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

  describe 'nth move' do
    context 'when n is 0' do
      it 'returns an empty board' do
        board = Quasifractal.new.nth_move(0)
        empty_board = Quasifractal.new.empty_board

        expect(board).to eq empty_board
      end
    end

    context 'when n is 1' do
      xit 'returns a board with the first X move' do
        quasifractal = Quasifractal.new
        board = quasifractal.nth_move(1)
        first_move = Quasifractal.new.first_move

        expect(board).to eq first_move
      end
    end

    context 'when n is 2' do
      it 'returns a board with thefirst O move' do
        quasifractal = Quasifractal.new
        board = quasifractal.nth_move(2)
        second_move = Quasifractal.new.second_move

        expect(board).to eq second_move
      end
    end

    context 'when n is 3' do
      it 'returns a board with the second X move' do
        quasifractal = Quasifractal.new
        board = quasifractal.nth_move(3)
        # second_move = Quasifractal.new.second_move

        # expect(board).to eq second_move
        binding.pry
      end
    end
  end

  describe 'depth' do
    context 'empty board' do
      it 'returns 0' do
        quasifractal = Quasifractal.new

        expect(quasifractal.depth).to eq 0
      end
    end

    context 'first move' do
      it 'returns 1' do
        quasifractal = Quasifractal.new
        quasifractal.first_move!

        expect(quasifractal.depth).to eq 1
      end
    end

    context 'second move' do
      it 'returns 2' do
        quasifractal = Quasifractal.new
        quasifractal.second_move!

        expect(quasifractal.depth).to eq 2
      end
    end
  end

  describe 'to_html' do
    it 'prints a first-move board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(1)

      quasifractal.to_html
    end

    fit 'prints a second-move board' do
      quasifractal = Quasifractal.new
      quasifractal.nth_move!(2)

      quasifractal.to_html
    end
  end
end
