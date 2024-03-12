require 'rails_helper'

RSpec.describe "GameLogsControllers", type: :request do
  describe "POST /game_logs_controllers" do
    before do
      post game_logs_path, params: { data: fixture_file_upload(file_path, 'text/plain') }
    end
    
    context 'with content' do
      let(:file_path) { 'spec/fixtures/log.txt' }
      
      it 'imports log', :aggregate_failures do
        expect(response).to have_http_status(200)
        expect(GameLog.count).to eq(1)
        expect(Game.count).to eq(21)
      end
    end

    context 'when is empty' do
      let(:file_path) { 'spec/fixtures/empty_log.txt' }
      
      it 'imports log', :aggregate_failures do
        expect(response).to have_http_status(200)
        expect(GameLog.count).to eq(1)
        expect(Game.count).to eq(0)
      end
    end
  end
end
