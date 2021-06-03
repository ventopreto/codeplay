#spec/system/admin_registers_lessons_spec.rb

describe 'admin registers lesson' do
  it 'successfully' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course =  Course.create(name: 'Introdução a ciencias da computação com python',
                        description: 'Um curso sobre python',
                        code: 'PYTHONCODE',
                        instructor: instructor,
                        price: '0800',
                        enrollment_deadline: '22/12/2033')
                        
          user_login
          visit root_path
          click_on 'Cursos'
          click_on "#{course.name}"
          click_on 'Registrar Aula'

          fill_in 'Nome da Aula', with: 'Aula 3'
          fill_in 'Descrição', with: 'Terceira aula do curso de introdução a python'
          fill_in 'Duração', with: 50
          click_on 'Criar Aula'
  end

  it 'and update with blank fields' do

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course =  Course.create(name: 'Introdução a ciencias da computação com python',
                              description: 'Um curso sobre python',
                              code: 'PYTHONCODE',
                              instructor: instructor,
                              price: '0800',
                              enrollment_deadline: '22/12/2033')

        user_login
        visit root_path
        click_on 'Cursos'
        click_on "#{course.name}"
        click_on 'Registrar Aula'

        fill_in 'Nome da Aula', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Duração', with: ''
        click_on 'Criar Aula'

        expect(page).to have_content("Você deve informar todos os dados da aula")

  end

      it 'and click on back button' do

        instructor = Instructor.create!(name: 'Fulano Sicrano',
        email: 'fulano@codeplay.com.br')    
    
        course =  Course.create(name: 'Introdução a ciencias da computação com python',
                                  description: 'Um curso sobre python',
                                  code: 'PYTHONCODE',
                                  instructor: instructor,
                                  price: '0800',
                                  enrollment_deadline: '22/12/2033')

        user_login 
        visit root_path
        click_on 'Cursos'
        click_on "#{course.name}"
        click_on  'Registrar Aula'
        click_on 'Voltar'

        expect(current_path).to eq admin_course_path(course)
      end

      it 'cannot access create lesson page throgh routes without login' do
        
        instructor = Instructor.create!(name: 'Fulano',
        email: 'fulano@codeplay.com.br')
    
        course =  Course.create(name: 'Introdução a ciencias da computação com python',
                                  description: 'Um curso sobre python',
                                  code: 'PYTHONCODE',
                                  instructor: instructor,
                                  price: '0800',
                                  enrollment_deadline: '22/12/2033')

        visit new_admin_course_lesson_path(course)

        expect(current_path).to eq(new_user_session_path)
      end

      it 'cannot access create lesson form page throgh routes without login' do
        
        instructor = Instructor.create!(name: 'Fulano',
        email: 'fulano@codeplay.com.br')
    
        course =  Course.create(name: 'Introdução a ciencias da computação com python',
                                  description: 'Um curso sobre python',
                                  code: 'PYTHONCODE',
                                  instructor: instructor,
                                  price: '0800',
                                  enrollment_deadline: '22/12/2033')

        post admin_course_lessons_path(course), params:{lesson: {name: 'Aula 1', duration: 40, description: 'Seila' }}

        expect(response).to redirect_to(new_user_session_path)
      end
end