#spec/system/admin_view_lessons_spec

require 'rails_helper'

describe 'Admin view lessons' do
  it 'successfully' do
    
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

                        
    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'React'
    click_on 'Ver Aulas'


    expect(page).to have_content("#{lesson.name}")
  end

  it 'and view details' do


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


    user_login
    visit root_path
    click_on 'Cursos'
    click_on 'React'
    click_on 'Ver Aulas'
    click_on 'Apresentação'

    expect(page).to have_content("#{lesson.name}")
    expect(page).to have_content("#{lesson.description}")
    expect(page).to have_content("#{lesson.duration}")
  end

  it 'cannot access lessons throgh routes without login' do
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

    visit admin_course_lessons_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
  it 'cannot access lessons details throgh routes without login' do
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

    visit admin_course_lesson_path(course, lesson)

    expect(current_path).to eq(new_user_session_path)
  end
end