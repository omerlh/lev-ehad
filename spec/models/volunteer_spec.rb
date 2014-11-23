require 'spec_helper' 
require 'nulldb_rspec'

#include NullDB::RSpec::NullifiedDatabase

describe Volunteer do 
  it "has a valid factory" do 
  	v = FactoryGirl.create(:volunteer_with_volunteer_availabilities)
  	v.volunteer_availabilities(true)
  	expect(v).to be_valid
  end
  it {should have_many(:volunteer_availabilities)}

  it {should validate_presence_of(:first_name)}
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:phone_number)}
end