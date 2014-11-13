class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :gender
      t.string :identification_number
      t.boolean :has_char
      t.text :qualifications
      t.text :remarks
      t.integer :age
      t.string :phone_number

      t.timestamps
    end
  end
end
