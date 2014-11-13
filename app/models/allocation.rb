class Allocation < ActiveRecord::Base
  belongs_to :volunteeravailabality
  belongs_to :allocationrequest
end
