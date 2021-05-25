class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @instructors = Instructor.all
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      flash[:alert] = 'Você deve informar todos os dados do curso'
        render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
    @instructors = Instructor.all
  end

  def update
    @instructors = Instructor.all
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      flash[:alert] = 'Você deve informar todos os dados do curso'
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      flash[:alert] = 'Curso removido com sucesso'
      redirect_to root_path
    end
  end

private

def course_params
  params.require(:course).permit(:name,:description,:code,:price, :instructor_id,:enrollment_deadline)
end

end