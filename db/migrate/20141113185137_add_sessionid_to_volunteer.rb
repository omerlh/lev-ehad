class AddSessionidToVolunteer < ActiveRecord::Migration
  def change
    add_column :volunteers, :sessionid, :string
  end
end
