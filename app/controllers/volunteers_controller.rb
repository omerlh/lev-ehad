class VolunteersController < ApplicationController
  def new
    @volunteer = Volunteer.new
  end

  def create
    @v = Volunteer.create(params.require(:volunteer).permit(:first_name, :last_name, :address,
                                                            :gender, :identification_number, :has_char,
                                                            :qualifications, :remarks, :age, :phone_number,
                                                            :email))
    @v.save

  end

  def show
  	@volunteer = Volunteer.all
  end

  def delete
  end
end
