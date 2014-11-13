class Hamal < ActiveRecord::Base
    has_many :allocation_requests

    def self.status_for day
    	AllocationRequest.where(day: day).includes(:hamal).map do |allocation_request| 
    		{
    			hamal_id: allocation_request.hamal.id,
                allocation_request_id: allocation_request.id,
    			name: allocation_request.hamal.name,
    			requested_amount: allocation_request.requested_amount,
                allocated_amount: allocation_request.allocated_amount,
    		}
    	end
    end


end
