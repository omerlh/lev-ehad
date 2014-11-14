class VolunteersController < ApplicationController
  def new
    @volunteer = Volunteer.new
  end

  def create
    @v = Volunteer.create(params.require(:volunteer).permit(:first_name, :last_name, :address,
                                                            :gender, :identification_number, :has_char,
                                                            :qualifications, :remarks, :age, :phone_number,
                                                            :email))


    params['from_day'].upto(params['to_day']) { |date| @v.volunteer_availabilities.create(:day => date)}

    #@va = @v.volunteer_availabilities.new()

    @v.save

  end

  def show
  	@volunteer = Volunteer.all
  end

  def delete
  end


end
