class GameLogsController < ApplicationController
  def create
    if ImportGameLogService.call(File.open(params[:data].path), params[:data].original_filename)
      render status: 200
    else
      render status: 422
    end
  end
end
