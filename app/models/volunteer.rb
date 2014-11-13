class Volunteer < ActiveRecord::Base
    has_many :volunteer_availabilities
end
