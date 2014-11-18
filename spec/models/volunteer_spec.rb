require 'spec_helper' 

describe Volunteer do 
  it "has a valid factory" do 
  	FactoryGirl.create(:Volunteer).should be_valid 
  end
  it "is invalid without a firstname" 
  it "is invalid without a lastname" 
  it "returns a Volunteer's full name as a string" 
end