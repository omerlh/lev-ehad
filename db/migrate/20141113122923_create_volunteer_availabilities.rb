class CreateVolunteerAvailabilities < ActiveRecord::Migration
  def change
    create_table :volunteer_availabilities do |t|
      t.references :volunteer
      t.date :day

      t.timestamps
    end
  end
end
