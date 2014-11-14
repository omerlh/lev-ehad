class StatisticsController < ApplicationController
  def show

  end

  def sum_volunteers
    start_day = Date.parse(params[:start_day])
    end_day = Date.parse(params[:end_day])
    count = AllocationRequest.where(:day => start_day..end_day).group(:day).sum(:allocated_amount)
    render :json => count
  end
end
