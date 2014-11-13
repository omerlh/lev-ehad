class AddAllocatedAmountToAllocationRequests < ActiveRecord::Migration
  def change
    add_column :allocation_requests, :allocated_amount, :integer
  end
end
