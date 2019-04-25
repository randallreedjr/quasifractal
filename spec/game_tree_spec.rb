describe GameTree do
  let(:game_tree) { GameTree.new(board) }
  let(:empty_board) { [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
  let(:incomplete_board_winner_x) { ['X','X','X','O','O', nil, nil, nil, nil] }
  let(:complete_board_winner_x) { ['X', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'O'] }
  let(:incomplete_board_winner_o) { ['X','X','O','X','O', nil, 'O', nil, nil] }
  let(:complete_board_no_winner) { ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'] }
  let(:incomplete_board_no_winner) { ['X','O','X','O','X', nil, nil, nil, nil] }

  describe 'value' do
    context 'when board is empty' do
      let(:board) { empty_board }
      it 'returns 0' do
        expect(game_tree.value).to eq 0
      end
    end

    context 'when board is incomplete' do
      let(:board) { incomplete_board_no_winner }
      it 'returns 0' do
        expect(game_tree.value).to eq 0
      end
    end

    context 'when board is incomplete and X has won' do
      let(:board) { incomplete_board_winner_x }

      it 'returns 1 for X' do
        expect(game_tree.value('X')).to eq 1
      end

      it 'returns -1 for O' do
        expect(game_tree.value('O')).to eq -1
      end
    end

    context 'when board is complete and X has won' do
      let(:board) { complete_board_winner_x }

      it 'returns 1 for X' do
        expect(game_tree.value('X')).to eq 1
      end

      it 'returns -1 for O' do
        expect(game_tree.value('O')).to eq -1
      end
    end

    context 'when board is incomplete and O has won' do
      let(:board) { incomplete_board_winner_o }

      it 'returns -1 for X' do
        expect(game_tree.value('X')).to eq -1
      end

      it 'returns 1 for O' do
        expect(game_tree.value('O')).to eq 1
      end
    end

    context 'when board is complete and no one has won' do
      let(:board) { complete_board_no_winner }

      it 'returns 0 for X' do
        expect(game_tree.value('X')).to eq 0
      end

      it 'returns 0 for O' do
        expect(game_tree.value('O')).to eq 0
      end
    end
  end
end
