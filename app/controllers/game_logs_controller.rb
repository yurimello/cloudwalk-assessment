class GameLogsController < ApplicationController
  def create
    if game_log = GameLog.create(filename: params[:data].original_filename)
      game_log.file.attach(params[:data])
      render status: 200
    else
      render status: 422
    end
  end
end
