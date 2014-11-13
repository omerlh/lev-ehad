class AllocationRequestsController < ApplicationController
  def create
    @a = AllocationRequest.create(params.require(:allocation_request).permit(:requested_amount, :day, :description, :hamal_id))
    @a.save
  end

  def new
    @hamals = Hamal.all
    @allocation_request = AllocationRequest.new
  end

  def show
    @allocation_requests = AllocationRequest.all
  end
end
