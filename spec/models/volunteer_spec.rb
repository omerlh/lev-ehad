require 'spec_helper' 
require 'nulldb_rspec'

include NullDB::RSpec::NullifiedDatabase

describe Volunteer do 
  it "has a valid factory" do 
  	v = FactoryGirl.create(:volunteer_with_volunteer_availabilities)
  	expect(v).to be_valid
  end

  it {should have_many(:volunteer_availabilities)}

  it {should validate_presence_of(:first_name)}
  it {should validate_presence_of(:last_name)}
  it {should validate_presence_of(:phone_number)}

  it "should have volunteer availabilities" do
  	v = FactoryGirl.build(:volunteer_with_volunteer_availabilities, volunteer_avilabilities_count: 0)
  	expect(v).not_to be_valid
  end

  describe "phone number validation" do
  	context "invalid numbers" do
  		["444", "0-0", "05468390089", "+97254689008"].each do |str| 
  			it "#{str}" do 
  				v = FactoryGirl.build(:volunteer_with_volunteer_availabilities, :phone_number => str)
  				expect(v).not_to be_valid
  			end
  		end
  	end
  	context "valid numbers" do
  		["054-6839008", "0546839008"].each do |str| 
  			it "#{str}" do 
  				v = FactoryGirl.build(:volunteer_with_volunteer_availabilities, :phone_number => str)
  				expect(v).to be_valid
  			end
  		end
  	end
  end

end