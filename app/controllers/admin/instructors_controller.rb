class Admin::InstructorsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show edit destroy]
  def index
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
   if @instructor.save
    flash[:success] = t('.success')
    redirect_to [:admin, @instructor]
  else  
    flash[:fail] = t('.fail')
    render :new
  end
end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
  if @instructor.update(instructor_params)
    flash[:success] = t('.success')
    redirect_to [:admin, @instructor]
  else 
  flash[:fail] = t('.fail')
  render :edit
    end
  end

def destroy
    @instructor = Instructor.find(params[:id])
    @instructor.destroy
    flash[:success] = t('.success')
    redirect_to root_path
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
  end
end