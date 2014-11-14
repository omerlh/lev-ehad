require 'volunteer_availability'

class AllocationController < ApplicationController

  protect_from_forgery with: :null_session


  def index
  end


  def available_volunteers
    # Todo - status 0 or 2
  	volunteers = Volunteer.available_for_day parse_date(), request.session_options[:id]
    render :json => volunteers
  end

  def hamals_status
  	statuses = Hamal.status_for parse_date()
  	render :json => statuses
  end

  def dealloc_volunteer
  	volunteer_id = params['volunteer_id']
    day = parse_date


  	VolunteerAvailability.where(volunteer_id: volunteer_id, day: day).delete_all

    render :json => { ok: true }
  end

  def allocate_volunteer
    volunteer_id = params['volunteer_id']
    hamal_id = params['hamal_id']
    day = parse_date

    Rails.logger.debug(hamal_id)

    volunteer_availbility = VolunteerAvailability.where(volunteer_id: volunteer_id, day: day).first  
    volunteer_availbility.status = STATUS[:MAIN_HAMAL_ALLOCATED]
    volunteer_availbility.hamal_id = hamal_id
    volunteer_availbility.save 
    
    allocation_request_id = params['allocation_request_id']
    
    
    ar = AllocationRequest.find_by_id(allocation_request_id)
    ar.allocated_amount = ar.allocated_amount + 1
    ar.save

    render :json => { ok: true }
  end

  def parse_date
  	Date.parse(params['date'])
  end


protected

  def json_request?
    request.format.json?
  end
end
