class ChangeVolunteerIdsToVolunteerId < ActiveRecord::Migration
  def change
  	remove_column :volunteer_availabilities, :volunteers_id, :integer
  	add_column :volunteer_availabilities, :volunteer_id, :integer
  end
end
