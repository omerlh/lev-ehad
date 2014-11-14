STATUS = {
  	UNALLOCATED: 0,
  	MAIN_HAMAL_ALLOCATED: 1,
  	LOCAL_HAMAL_DISAPRROVED: 2,
	LOCAL_HAMAL_ALLOCATED: 3
}


class VolunteerAvailability < ActiveRecord::Base
    belongs_to :volunteer
end
