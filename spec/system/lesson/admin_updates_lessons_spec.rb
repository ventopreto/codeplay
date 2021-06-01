#spec/system/admin_updates_lessons_spec.rb

require 'rails_helper'

describe 'admin updates lessons' do
  it 'successfully' do
    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    instructor = Instructor.create(name: 'Fabio kon',
                                                    email: 'fabio@gmail.com')
    course = Course.create(name: 'Python 1',
                                          code: 'PYTHONCODE',
                                          price: '0800',
                                          instructor: instructor,
                                          enrollment_deadline: '25/05/2021')
                 lesson = Lesson.create(name: 'aula 1',
                                        description: 'primeira aula do curso',
                                        duration: 50,
                                        course:course)
                                        Order.create!(user: user, course: course)
                    

    login_as user, scope: :user   
    visit root_path
    click_on 'Cursos'
    click_on "#{course.name}"
    click_on 'Ver Aulas'
    click_on "#{lesson.name}"
    click_on 'Editar'
    fill_in 'Nome', with: 'Aula 1'
    fill_in 'Descrição', with: 'Primeira Aula do Curso'
    fill_in 'Duração', with: 40
    click_on 'Atualizar Aula'

    expect(page).to have_content('Aula 1')
    expect(page).to have_content('Primeira Aula do Curso')
    expect(page).to have_content('40 minutos')
  end
end
