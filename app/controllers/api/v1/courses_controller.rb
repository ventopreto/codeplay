class Api::V1::CoursesController < ActionController::API

  def index
    @courses = Course.all 
    render json: @courses.as_json(except: [:id, :created_at, :updated_at, :instructor_id], include: :instructor), status: 200
  end
  
  def show
    @course = Course.find_by(code: params[:code])
    if @course
    render json: @course
    else 
      head 404
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
    render json: @course, status:201
    else
      head 422
    end
  end


def update
  @course = Course.find_by(code: params[:code])
  if @course.update(course_params)
    render json: @course, status: 200
  else
    head 422
    end
  end

  def destroy
    @course = Course.find_by(code: params[:code])
    if @course.destroy
      head 204
    else
      head 422
    end
  end

end

private

def course_params
  params.require(:course).permit(:name,:description,:code,:price, :instructor_id,:enrollment_deadline)
end