class CoursesController < ApplicationController
before_action :set_course, only: %i{show order}

  def index
    @courses = Course.all
  end

  def show
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


end