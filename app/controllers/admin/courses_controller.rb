class Admin::CoursesController < ApplicationController
before_action :authenticate_user!
before_action :set_course, only: %i[show edit update destroy order]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @instructors = Instructor.all
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_path(@course)
    else
      flash[:fail] = t('.fail')
        render :new
    end
  end

  def edit
    @instructors = Instructor.all
  end

  def update
    @instructors = Instructor.all
    if @course.update(course_params)
      flash[:success] = t('.success')
      redirect_to admin_course_path(@course)
    else
      flash[:fail] = t('.fail')
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t('.success') 
      redirect_to root_path
  end
end

  def order
    current_user.orders.create(course: @course, price: @course.price)
    flash[:success] = 'Curso comprado com sucesso'
    redirect_to my_courses_courses_path
  end

  def my_courses
    @orders = current_user.orders
  end

private

def set_course
  @course = Course.find(params[:id])
end

def course_params
  params.require(:course).permit(:name,:description,:code,:price, :instructor_id,:enrollment_deadline)
end

end