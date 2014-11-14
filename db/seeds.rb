require 'date'
require 'faker'

print '[CAUTION] Removing all data...'
User.delete_all
Volunteer.delete_all
VolunteerAvailability.delete_all
Hamal.delete_all
AllocationRequest.delete_all

u = User.new(
    email: "admin@example.com",
    password: "1234",
    password_confirmation: "1234",
    admin: true
)
u.skip_confirmation!
u.save!



100.times do
    v = Volunteer.create(
        first_name: Faker::Lorem.words(1).first,
        last_name: Faker::Lorem.words(1).first,
        address: Faker::Address.street_address,
        gender: 'F',
        identification_number: Faker::Number.number(9),
        has_char: false,
        qualifications: Faker::Lorem.words(4).join(' '),
        remarks: Faker::Lorem.sentence,
        age: Faker::Number.number(2),
        phone_number: Faker::PhoneNumber.cell_phone
    )

    2.times do |vic|
        v.volunteer_availabilities.create(
            day: vic % 2 == 0 ? Date.today - 1: Date.today,
            status: 0
        )
    end
end


10.times do
    h = Hamal.create(
        name: Faker::Company.name,
        location: Faker::Address.city,
        description: Faker::Lorem.sentence
    )

    2.times do |ari|
        r = h.allocation_requests.create(
            day: ari % 2 == 0 ? Date.today - 1: Date.today,
            requested_amount: 6,
            allocated_amount: 0,
            description: Faker::Lorem.sentence
        )

    end

end
