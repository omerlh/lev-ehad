class AllocationController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
  end


  def available_volunteers
  	volunteers = Volunteer.available_for_day parse_date()
    render :json => volunteers
  end

  def hamals_status
  	statuses = Hamal.status_for parse_date()
  	render :json => statuses
  end

  def parse_date
  	Date.parse(params['date'])
  end
end
