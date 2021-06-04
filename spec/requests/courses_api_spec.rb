require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')
  
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', price: 10,
                     instructor: instructor,
                     enrollment_deadline: '22/12/2033')
      another_course = Course.create!(name: 'Rails', description: 'Um curso de Rails',
      code: 'RailsBASIC', price: 10,
      instructor: instructor,
      enrollment_deadline: 1.month.from_now)

      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to eq('Ruby')
      expect(parsed_body[1]['name']).to eq('Rails')
    end

    it 'returns no courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body).to be_empty
    end
  end
  context 'GET /api/v1/courses/:code' do
    it 'should return a course' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')
  
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                     code: 'RUBYBASIC', price: 10,
                     instructor: instructor,
                     enrollment_deadline: '22/12/2033')
      another_course = Course.create!(name: 'Rails', description: 'Um curso de Rails',
      code: 'RailsBASIC', price: 10,
      instructor: instructor,
      enrollment_deadline: 1.month.from_now)

      get "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(response.body).to_not include('RailsBASIC')
    end

    it 'should not found course by code' do
      get "/api/v1/courses/ABC157"


      expect(response).to have_http_status(404)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')

      post '/api/v1/courses', params: {
        course:{name: 'Ruby on Rails', description: 'Um curso de rails', code: 'RAILSCODE',
         price: '30', instructor_id: instructor.id}
      }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby on Rails')
      expect(parsed_body['description']).to eq('Um curso de rails')
      expect(parsed_body['code']).to eq('RAILSCODE')
      expect(parsed_body['price']).to eq('30.0')
    end

    it 'should fail to create a course' do
      post '/api/v1/courses', params: {
        course:{name: 'Ruby on Rails', description: 'Um curso de rails', code: 'RAILSCODE'}
      }

      expect(response).to have_http_status(422)
    end
  end

  context 'PATCH /api/v1/courses' do
    it 'should update a course' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')

      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      instructor: instructor,
      enrollment_deadline: '22/12/2033')

      patch "/api/v1/courses/#{course.code}", params: {
        course:{name: 'Ruby on Rails', description: 'Um curso de rails', code: 'RAILSCODE',
         price: '30', instructor_id: instructor.id}
      }

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby on Rails')
      expect(parsed_body['description']).to eq('Um curso de rails')
      expect(parsed_body['code']).to eq('RAILSCODE')
      expect(parsed_body['price']).to eq('30.0')
    end

    it 'should fail to update a course' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')

      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      instructor: instructor,
      enrollment_deadline: '22/12/2033')
      
      patch "/api/v1/courses/#{course.code}", params: {
        course:{name: '', description: '', code: ''}
      }

      expect(response).to have_http_status(422)
    end
  end

  context 'DELETE /api/v1/courses/:code' do
    it 'should delete a course' do

      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')

      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      instructor: instructor,
      enrollment_deadline: '22/12/2033')

      delete "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(204)
    end
  end

  private
  def parsed_body
    JSON.parse(response.body)
  end
end