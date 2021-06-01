#spec/system/admin_view_lessons_spec

require 'rails_helper'

describe 'Admin view lessons' do
  it 'successfully' do

    user = User.create!(email: 'x@gmail.com',
    password: '123456')
    
    instructor = Instructor.create(name: 'João',
    email: 'joão@gmail.com')

    course = Course.create!(name: 'React',
                  description: 'Um curso sobre React',
                  code: 'REACTCODE',
                  instructor: instructor,
                  price: '1000',
                  enrollment_deadline: '22/12/2033')

lesson = Lesson.create!(name: 'Apresentação',
                    description: 'Aula iniciação do curso de react',
                    duration: 50,
                    course: course)

                        

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Cursos'
    click_on 'React'
    click_on 'Ver Aulas'


    expect(page).to have_content("#{lesson.name}")
  end

  it 'and view details' do

    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    instructor = Instructor.create(name: 'João',
    email: 'joão@gmail.com')

    course = Course.create!(name: 'React',
                  description: 'Um curso sobre React',
                  code: 'REACTCODE',
                  instructor: instructor,
                  price: '1000',
                  enrollment_deadline: '22/12/2033')

lesson = Lesson.create!(name: 'Apresentação',
                    description: 'Aula iniciação do curso de react',
                    duration: 50,
                    course: course)
                    Order.create!(user: user, course: course)

    login_as user, scope: :user
    visit root_path
    click_on 'Cursos'
    click_on 'React'
    click_on 'Ver Aulas'
    click_on 'Apresentação'

    expect(page).to have_content("#{lesson.name}")
    expect(page).to have_content("#{lesson.description}")
    expect(page).to have_content("#{lesson.duration}")
  end
end