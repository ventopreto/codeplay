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
      flash[:alert] = 'Aula Criada com sucesso'
      redirect_to course_lessons_path(@course)
    else
      flash[:alert] = 'Não foi possivel criar a aula, preencha todos os campos'
      render :new
    end
  end

def show
  @lesson = Lesson.find(params[:id])
end



  private

  def get_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description)
  end
end

