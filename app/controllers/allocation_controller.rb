class AllocationController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
  end


  def available_volunteers
      day = Date.parse(params['date'])
      @volunteers = Volunteer.available_for_day day

      render :json => @volunteers
  end
end
