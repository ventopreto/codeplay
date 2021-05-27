# spec/system/admin_deletes_courses_spec

require 'rails_helper'

describe 'admin deletes courses' do
  it 'sucessfully' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course = Course.create!(name: 'Python',
                            description: 'Um curso de python',
                            code: 'PYTHONROCKS',
                            price: '350',
                            instructor:instructor,
                            enrollment_deadline: '31/08/2022')
                 lesson = Lesson.create!(name: 'Apresentação',
                                          description: 'Aula Inicial',
                                          duration: 50,
                                          course: course)

    visit root_path
    click_on 'Cursos'
    click_on "#{course.name}"
    click_on 'Ver Aulas'
    click_on "#{lesson.name}"
    expect {click_on 'Deletar'}.to change {Lesson.count}.by(-1)
    expect(page).to have_content('Aula removida com sucesso')
  end
end