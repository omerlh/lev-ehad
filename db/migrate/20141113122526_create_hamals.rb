class CreateHamals < ActiveRecord::Migration
  def change
    create_table :hamals do |t|
      t.string :name
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
