describe GameTree do
  let(:game_tree) { GameTree.new(board) }

  describe 'minmax' do
    # Replace boards with values
    context 'when next move will be a win' do
      # if there's only one move, replace entire array with value
      # ['X', 'O', 'X', 'X', 'O', 'O',
      # ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'],
      # 'X', 'O']
      # => [nil, nil, nil, nil, nil, nil, 1, nil, nil] for 'X'
      # or [{index: 6, value: 1}] for 'X'
      # Not sure yet if we'll need to retain the nils, it will become clearer
      # as we move up higher in the tree
      let(:board) do
        ['X', 'O', 'X', 'X', 'O', 'O',
          ['X', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'O'],
        'X', 'O']
      end

      it 'replaces a leaf node with a value' do
        expected_result = ['X', 'O', 'X', 'X', 'O', 'O', 1, 'X', 'O']
        expect(game_tree.minmax(mark: 'X')).to eq expected_result
      end
    end
  end

  describe 'value' do
    let(:empty_board) { [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
    let(:incomplete_board_winner_x) { ['X','X','X','O','O', nil, nil, nil, nil] }
    let(:complete_board_winner_x) { ['X', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'O'] }
    let(:incomplete_board_winner_o) { ['X','X','O','X','O', nil, 'O', nil, nil] }
    let(:complete_board_no_winner) { ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'] }
    let(:incomplete_board_no_winner) { ['X','O','X','O','X', nil, nil, nil, nil] }

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
        expect(game_tree.value(mark: 'X')).to eq 1
      end

      it 'returns -1 for O' do
        expect(game_tree.value(mark: 'O')).to eq -1
      end
    end

    context 'when board is complete and X has won' do
      let(:board) { complete_board_winner_x }

      it 'returns 1 for X' do
        expect(game_tree.value(mark: 'X')).to eq 1
      end

      it 'returns -1 for O' do
        expect(game_tree.value(mark: 'O')).to eq -1
      end
    end

    context 'when board is incomplete and O has won' do
      let(:board) { incomplete_board_winner_o }

      it 'returns -1 for X' do
        expect(game_tree.value(mark: 'X')).to eq -1
      end

      it 'returns 1 for O' do
        expect(game_tree.value(mark: 'O')).to eq 1
      end
    end

    context 'when board is complete and no one has won' do
      let(:board) { complete_board_no_winner }

      it 'returns 0 for X' do
        expect(game_tree.value(mark: 'X')).to eq 0
      end

      it 'returns 0 for O' do
        expect(game_tree.value(mark: 'O')).to eq 0
      end
    end
  end
end
