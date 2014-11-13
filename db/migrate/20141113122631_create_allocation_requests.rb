class CreateAllocationRequests < ActiveRecord::Migration
  def change
    create_table :allocation_requests do |t|
      t.integer :amount
      t.date :day
      t.text :description
      t.references :hamal

      t.timestamps
    end
  end
end
