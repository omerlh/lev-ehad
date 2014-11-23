require 'faker'

FactoryGirl.define do 
  factory :volunteer_availability do |f| 
  	day { Time.now }
  end
end