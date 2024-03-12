class GameLogsController < ApplicationController
  def create
    if ImportGameLogService.call(params[:data])
      render status: 200
    else
      render status: 422
    end
  end
end
