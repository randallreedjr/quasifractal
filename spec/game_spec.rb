describe Game do
  let(:game) { Game.new(board) }
  let(:empty_board) { [nil, nil, nil, nil, nil, nil, nil, nil, nil] }
  let(:incomplete_board_winner_x) { ['X','X','X','O','O', nil, nil, nil, nil] }
  let(:complete_board_winner_x) { ['X', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'O'] }
  let(:incomplete_board_winner_o) { ['X','X','O','X','O', nil, 'O', nil, nil] }
  let(:complete_board_no_winner) { ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'] }
  let(:incomplete_board_no_winner) { ['X','O','X','O','X', nil, nil, nil, nil] }

  describe 'determining winner' do
    context 'when board is empty' do
      let(:board) { empty_board }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be false
      end

      it 'returns correct winner' do
        expect(game.winner).to be nil
      end
    end

    context 'when board is incomplete' do
      let(:board) { incomplete_board_no_winner }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be false
      end

      it 'returns correct winner' do
        expect(game.winner).to be nil
      end
    end

    context 'when board is incomplete and X has won' do
      let(:board) { incomplete_board_winner_x }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be true
      end

      it 'returns correct winner' do
        expect(game.winner).to eq 'X'
      end
    end

    context 'when board is complete and X has won' do
      let(:board) { complete_board_winner_x }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be true
      end

      it 'returns correct winner' do
        expect(game.winner).to eq 'X'
      end
    end

    context 'when board is incomplete and O has won' do
      let(:board) { incomplete_board_winner_o }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be true
      end

      it 'returns correct winner' do
        expect(game.winner).to eq 'O'
      end
    end

    context 'when board is complete and no one has won' do
      let(:board) { complete_board_no_winner }

      it 'returns correct value for game over' do
        expect(game.game_over?).to be true
      end

      it 'returns correct winner' do
        expect(game.winner).to eq 'C'
      end
    end
  end
end
