require 'rails_helper'

describe 'User authentication' do
  it 'cannot access create without login' do
    post admin_courses_path, params: {course: {name: 'Ruby'}}
    expect(response).to redirect_to(new_user_session_path)
  end
end