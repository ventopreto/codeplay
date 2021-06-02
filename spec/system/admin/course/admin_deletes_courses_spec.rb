# spec/system/admin_deletes_courses_spec

require 'rails_helper'

describe 'admin deletes courses' do
  it 'sucessfully' do
    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    Course.create!(name: 'Python',
                            description: 'Um curso de python',
                            code: 'PYTHONROCKS',
                            price: '350',
                            instructor:instructor,
                            enrollment_deadline: '31/08/2022')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Cursos'
    click_on 'Python'
    expect {click_on 'Deletar Curso'}.to change {Course.count}.by(-1)
    expect(page).to have_content('Curso removido com sucesso')
  end

  it 'cannot delete without login' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   instructor: instructor,
                   enrollment_deadline: '22/12/2033')

    delete admin_course_path(course)
    expect(response).to redirect_to(new_user_session_path)
  end
end