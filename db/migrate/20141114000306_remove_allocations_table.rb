class RemoveAllocationsTable < ActiveRecord::Migration
  def change
  	drop_table :allocations
  end
end
