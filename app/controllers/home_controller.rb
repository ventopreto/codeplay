class HomeController < ApplicationController
  def index
    @courses = Course.available.not_draft
    if user_signed_in?
        redirect_to admin_courses_path
    end
  end
end
