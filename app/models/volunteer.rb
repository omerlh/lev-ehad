class Volunteer < ActiveRecord::Base
    has_many :volunteer_availabilities


    def self.available_for_day day
        VolunteerAvailability.where(day: day).includes(:volunteer).map(&:volunteer)
    end
end
