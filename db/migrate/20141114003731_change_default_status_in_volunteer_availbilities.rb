class ChangeDefaultStatusInVolunteerAvailbilities < ActiveRecord::Migration
  def change
  	change_column_default :volunteer_availabilities, :status, 0
  end
end
