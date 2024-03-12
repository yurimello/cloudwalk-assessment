require 'rails_helper'

RSpec.describe ImportGameLogService do
  let(:log_data) { fixture_file_upload(file_path, 'text/plain') }
  let(:file_path) { "spec/fixtures/#{file_name}" }
  let(:file_name) { 'log.txt' }
  let(:adapter) { double('adpater') }
  let(:attachment_instance) { double('attachment') }
  let(:game_data) { { id: 1, name: 'Game 1' } }

  before do 
    allow(adapter).to receive(:new).and_return(adapter_instance)
    allow(adapter_instance).to receive(:games).and_return([game_data])
    allow(adapter_instance).to receive(:game_id).and_return('game_id')
  end

  describe '.call' do
    let(:adapter_instance) { instance_double('TxtParser', games: [game_data], game_id: 'game_id') }
    it 'finds or creates a game log' do
      expect(GameLog).to receive(:find_or_create_by).with(filename: file_name)
      described_class.call(log_data, adapter)
    end

    context 'when game log is found' do
      let(:game_log) { create(:game_log, filename: file_name) }

      it 'creates games from parsed data' do
        expect(Game).to receive(:find_or_create_by).with(game_log_id: game_log.id, checksum: 'game_id')
        described_class.call(log_data, adapter)
      end
    end

  end
end