require 'rails_helper'

RSpec.describe "GameLogsControllers", type: :request do
  describe "POST /game_logs_controllers" do
    let(:request) { post game_logs_path, params: { data: fixture_file_upload(file_path, 'text/plain') } }
    let(:file_path) { 'spec/fixtures/log.txt' }
    
    before do
      request
    end
    
    context 'with content' do
      it 'imports log', :aggregate_failures do
        expect(response).to have_http_status(200)
        expect(GameLog.count).to eq(1)
        expect(Game.count).to eq(21)
        expect(GameActivity.count).to eq(1069)
        expect(WorldEnvironment.count + Player.count).to eq(11)
      end
    end

    context 'when uploads same file twice' do
      it 'does not add activities' do 
        expect { request }.to_not change(GameActivity, :count).from(1069)
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
