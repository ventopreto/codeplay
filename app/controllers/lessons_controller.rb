class LessonsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_course, only: %i[show index] 
  before_action :set_lesson, only: %i[show] 
  before_action :user_has_order, only: %i[show]

def index
  @lessons = @course.lessons
end

def show
end

  private

  def user_has_order
    redirect_to @lesson.course unless current_user.courses.include?(@lesson.course)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

end

