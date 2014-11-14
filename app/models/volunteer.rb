class Volunteer < ActiveRecord::Base
    has_many :volunteer_availabilities


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
end
