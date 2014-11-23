require 'faker'

FactoryGirl.define do 

  factory :volunteer do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    # user_with_posts will create post data after the user has been created
    factory :volunteer_with_volunteer_availabilities do
      # volunteer_avilabilities_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        volunteer_avilabilities_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      before(:create) do |volunteer, evaluator|
        evaluator.volunteer_avilabilities_count.times {
        	volunteer.volunteer_availabilities << FactoryGirl.create(:volunteer_availability, :volunteer => volunteer)}
      end
    end
  end

end