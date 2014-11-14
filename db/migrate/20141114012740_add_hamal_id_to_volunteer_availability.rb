class AddHamalIdToVolunteerAvailability < ActiveRecord::Migration
  def change
    add_column :volunteer_availabilities, :hamal_id, :integer
  end
end
