require 'spec_helper' 
require 'nulldb_rspec'

include NullDB::RSpec::NullifiedDatabase

describe VolunteerAvailability do
	it {should belong_to(:volunteer)}
	it {should validate_presence_of(:day)}
	it {should validate_presence_of(:volunteer)}

end