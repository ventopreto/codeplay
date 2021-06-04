class HomeController < ApplicationController
  def index
    @courses = Course.available
    if user_signed_in?
        redirect_to admin_courses_path
    end
  end
end
