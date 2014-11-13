Lev Ehad
========


Development:
1. Fork this repository
2. Clone
3. cd into lev-ehad and run the next commands:
```
bundle install
rake db:create
rake db:migrate
rails s
```
4. Install foreman, and run:
```
foreman start
```

Database Schema
================

Hamal
    = has many AllocationRequest
    - Name
    - Location
    - Description

Volunteer
    = has many VolunteerAvailabality
    - FirstName
    - LastName
    - Address
    - Gender
    - IdentificatoinNumber
    - HasCar
    - Qualifications
    - Remarks
    - Age
    - PhoneNumber

VolunteerAvailabality
    = belongs to Volunteer
    - Day

AllocationRequest
    = belongs to Hamal
    - Amount
    - Day
    - Description

Allocation
    = belongs to VolunteerAvailabality
    = belongs to AllocationRequest
    - Status
    - Reason
