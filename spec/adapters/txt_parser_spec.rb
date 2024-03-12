require 'rails_helper'

RSpec.describe TxtParser do
  let(:file_path) { 'spec/fixtures/log.txt' }
  let(:game_log_id) { 1 }
  let(:parser) { TxtParser.new(file_path) }

  describe '#games' do
    it 'parses games from log content' do
      games = parser.games
      expect(games).to be_an(Array)
      expect(games.size).to eq(21)
    end
  end

  describe '#game_id' do
    let(:content) { "InitGame: \n SomeData \n" }

    it 'generates a unique game ID' do
      game_id = parser.game_id(game_log_id, content)
      expect(game_id).to be_a(String)
      expect(game_id).not_to be_empty
    end
  end
end