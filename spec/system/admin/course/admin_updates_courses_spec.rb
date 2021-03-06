# spec/system/admin_updates_courses_spec.erb

require 'rails_helper'

describe 'Admin updates courses' do
  it 'sucessfully' do

   instructor = Instructor.create!(name: 'Fulano Sicrano', email: 'fulano@gmail.com')
    Course.create!(name: 'Ruby',
                       description: 'Um curso sobre ruby',
                        code: 'RUBYCODE',
                        price: '300,00',
                        instructor: instructor,
                        enrollment_deadline: '25/05/2021')

    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Editar'

    fill_in 'Nome', with: 'Ruby+Rails'
    fill_in 'Descrição', with: 'Um curso de ruby com ruby on rails'
    fill_in 'Código', with: 'RUBY+RAILSCODE'
    fill_in 'Preço', with: '500'
    select 'Fulano Sicrano', from: 'Professor'
    fill_in 'Data limite de matrícula', with: '30/05/2021'
    click_on 'Atualizar curso'


    expect(page).to have_content('Ruby+Rails')
    expect(page).to have_content('Um curso de ruby com ruby on rails')
    expect(page).to have_content('RUBY+RAILSCODE')
    expect(page).to have_content('R$ 500,00')
    expect(page).to have_content('30/05/2021')
    
  end

  it 'with blank attributes' do

    instructor = Instructor.create!(name: 'Fulano Sicrano', email: 'fulano@gmail.com')
    Course.create!(name: 'Ruby',
                       description: 'Um curso sobre ruby',
                        code: 'RUBYCODE',
                        price: '300,00',
                        instructor: instructor,
                        enrollment_deadline: '25/05/2021')

    user_login
  visit root_path
  click_on 'Cursos'
  click_on 'Ruby'
  click_on 'Editar'

  fill_in 'Nome', with: ''
  fill_in 'Descrição', with: ''
  fill_in 'Preço', with: ''
  fill_in 'Código', with: ''
  fill_in 'Data limite de matrícula', with: ''
  click_on 'Atualizar curso'

  expect(page).to have_content('não pode ficar em branco', count: 3)


  end
  it 'must be logged in to view edit courses through route' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')

    visit edit_admin_course_path(course)

    expect(current_path).to eq(new_user_session_path)
    
  end

  it 'must be logged in to view update courses through route' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')

    patch admin_course_path(course)

    expect(response).to redirect_to(new_user_session_path)
    
  end
end