class Allocation < ActiveRecord::Base
  belongs_to :volunteeravailability
  belongs_to :allocationrequest
end
