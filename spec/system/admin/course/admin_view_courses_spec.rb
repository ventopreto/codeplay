# spec/system/admin_view_courses_spec.rb

require 'rails_helper'

describe 'Admin view courses' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor:instructor,
                   enrollment_deadline: '22/12/2033')
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   instructor:instructor,
                   enrollment_deadline: '20/12/2033')

    user_login
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it 'and view details' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   instructor: instructor,
                   enrollment_deadline: '20/12/2033')

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it 'and no course is available' do

    user_login
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso dispon??vel')
  end

  it 'and return to home page' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end

  it 'and return to promotions page' do


    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')


    user_login
    visit root_path
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq(admin_courses_path)
  end

  it 'must be logged in to view courses button' do

    visit root_path

    expect(page).to_not have_link('Cursos')
    
  end

  it 'must be logged in to view courses through route' do
    visit admin_courses_path

    expect(current_path).to eq(new_user_session_path)
    
  end

  it 'must be logged in to view courses details through route' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')

    visit admin_course_path(course)

    expect(current_path).to eq(new_user_session_path)
    
  end
end
