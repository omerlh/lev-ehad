class AddStatusAndReasonToVolunteerAvailability < ActiveRecord::Migration
  def change
    add_column :volunteer_availabilities, :status, :integer
    add_column :volunteer_availabilities, :reason, :string
  end
end
