require 'rails_helper'

RSpec.describe "GameLogsControllers", type: :request do
  describe "POST /game_logs_controllers" do
    it "works! (now write some real specs)" do
      post game_logs_controllers_path
      expect(response).to have_http_status(200)
    end
  end
end
