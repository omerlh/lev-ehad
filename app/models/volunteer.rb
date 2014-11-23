class Volunteer < ActiveRecord::Base
    has_many :volunteer_availabilities, autosave: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone_number, presence: true

    validates_associated :volunteer_availabilities
    validates :volunteer_availabilities, :length => {:minimum => 1, :message=>"At least one volunteer_availability" }

    def self.available_for_day day, sessionid
      v = nil
      v = VolunteerAvailability
              .joins(:volunteer)
              .where( day: day,
                      status: [STATUS[:UNALLOCATED], STATUS[:LOCAL_HAMAL_DISAPRROVED]],
                      "volunteers.sessionid" => sessionid)
              .map(&:volunteer)

      if v.empty?
        Volunteer.transaction do
          v = VolunteerAvailability
                .joins(:volunteer)
                .where( day: day,
                        status: [STATUS[:UNALLOCATED], STATUS[:LOCAL_HAMAL_DISAPRROVED]],
                        "volunteers.sessionid" => nil)
                .limit(10)
                .lock(true)
                .map(&:volunteer)
                
          v.each do |volunteer|
            volunteer.sessionid = sessionid
            volunteer.save!
          end
        end
      end
      Rails.logger.debug(v.inspect)
      return v
    end

  def self.free_volunteers sessionid
    Volunteer.transaction do
      volunteers = Volunteer.where(sessionid: sessionid).lock(true)
      volunteers.each do |volunteer|
        volunteer.sessionid = nil
        volunteer.save!
      end
    end
  end

  def self.allocated_volunteers day, hamal_id
    VolunteerAvailability
      .joins(:volunteer)    
      .where(day: day, 
        hamal_id: hamal_id, 
        status: STATUS[:MAIN_HAMAL_ALLOCATED])
      .map(&:volunteer)      
                        
  end
end
