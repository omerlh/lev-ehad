class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.references :volunteer_availability, index: true
      t.references :allocation_requests
      t.integer :status
      t.string :reason

      t.timestamps
    end
  end
end
