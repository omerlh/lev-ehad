class VolunteerAvailabilityController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
  end


  def available_volunteers
      day = Date.parse(params['date'])
      @volunteers = Volunteer.available_for_day day, request.session_options[:id]
      render :json => @volunteers
  end

  def free_volunteers
    Volunteer.free_volunteers request.session_options[:id]
    render :json => { ok: true }
  end
end
