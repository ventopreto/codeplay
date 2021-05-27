class LessonsController < ApplicationController
  before_action :get_course

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
      redirect_to course_lessons_path(@course)
    else
      flash[:fail] = t('.fail')
      render :new
    end
  end

def show
  @lesson = Lesson.find(params[:id])
end

def edit
  @lesson = Lesson.find(params[:id])
end



def update 
  @lesson = Lesson.find(params[:id])
  if @lesson.update(lesson_params)
    flash[:success] = t('.success')

    redirect_to course_lesson_path(@lesson)
    else
      flash[:fail] = t('.fail')
      render :edit
  end
end

def destroy
  @lesson = Lesson.find(params[:id])
  if @lesson.destroy
    flash[:success] = t('.success')
    redirect_to root_path
    end
  end

  private

  def set_course
    @lesson = Lesson.find(params[:id])
  end

  def get_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :duration)
  end
end

