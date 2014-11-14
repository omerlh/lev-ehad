class AllocationApprovalController < ApplicationController
  protect_from_forgery with: :null_session

  def index
  	@hamals = Hamal.all
  end

  def available_volunteers 
  	date = parse_date
  	hamal_id = params['hamal_id']
  	volunteers = Volunteer.allocated_volunteers date, hamal_id
  	render :json => volunteers
  end

  def approve_volunteer
    volunteer_id = params['volunteer_id']
    hamal_id = params['hamal_id']
    date = parse_date
    
    va = VolunteerAvailability.where(volunteer_id: volunteer_id, hamal_id: hamal_id, day: date).first
    va.status = STATUS[:LOCAL_HAMAL_ALLOCATED]
    va.save

    render :json => { ok: true }
  end

  def deny_volunteer
    volunteer_id = params['volunteer_id']
    hamal_id = params['hamal_id']
    date = parse_date
    reason = params['reason']

    va = VolunteerAvailability.where(volunteer_id: volunteer_id, hamal_id: hamal_id, day: date).first
    va.status = STATUS[:LOCAL_HAMAL_DISAPRROVED]
    va.reason = params['reason']
    va.save

    render :json => { ok: true }
  end

  def parse_date
  	Date.parse(params['date'])
  end


end
