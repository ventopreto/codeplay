class Admin::LessonsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_course
  before_action :set_lesson, only: %i[show edit destroy update] 
  before_action :user_has_order, only: %i[show]

def index
  @lessons = @course.lessons
end

  def new
    @lesson = @course.lessons.build
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    if @lesson.save
      flash[:success] = t('.success')
      redirect_to admin_course_lessons_path(@course)
    else
      flash[:fail] = t('.fail')
      render :new
    end
  end

def show
end

def edit

end



def update 
  if @lesson.update(lesson_params)
    flash[:success] = t('.success')

    redirect_to admin_course_lesson_path(@lesson)
    else
      flash[:fail] = t('.fail')
      render :edit
  end
end

def destroy

  if @lesson.destroy
    flash[:success] = t('.success')
    redirect_to root_path
    end
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

  def lesson_params
    params.require(:lesson).permit(:name, :description, :duration)
  end
end

