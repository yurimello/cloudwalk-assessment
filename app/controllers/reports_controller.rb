class ReportsController < ApplicationController
  def index
    render json: GenerateReportService.call
  end
end
