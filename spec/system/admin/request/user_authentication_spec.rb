require 'rails_helper'

describe 'User authentication' do
  it 'cannot access create course without login' do
    post admin_courses_path, params: {course: {name: 'Ruby'}}
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot acess create instructor without login' do
    post admin_instructors_path, params: {instructor: {name: 'Guanabara'}}
    expect(response).to redirect_to(new_user_session_path)
  end


end