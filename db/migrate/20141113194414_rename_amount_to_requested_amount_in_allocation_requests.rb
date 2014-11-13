class RenameAmountToRequestedAmountInAllocationRequests < ActiveRecord::Migration
  def change
  	remove_column :allocation_requests, :amount, :integer
  	add_column :allocation_requests, :requested_amount, :integer
  end
end
