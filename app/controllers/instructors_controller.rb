class InstructorsController < ApplicationController
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
    @instructor = Instructor.create(instructor_params)
     if @instructor.save
      redirect_to @instructor
    else  
      flash[:alert] = 'Você deve informar todos os dados do professor'
      render :new
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
    @instructor = Instructor.find(params[:id])
    if @instructor.update(instructor_params)
      redirect_to @instructor
  else 
    flash[:alert] = 'Você deve informar todos os dados do professor'
    render :edit
  end
  end

  private
  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio)
  end
end