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

          visit root_path
          click_on 'Cursos'
          click_on "#{course.name}"
          click_on 'Registrar Aula'

          fill_in 'Nome da Aula', with: 'Aula 3'
          fill_in 'Descrição', with: 'Terceira aula do curso de introdução a python'
          click_on 'Criar Lesson'
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

        visit root_path
        click_on 'Cursos'
        click_on "#{course.name}"
        click_on 'Registrar Aula'

        fill_in 'Nome da Aula', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Criar Lesson'

        expect(page).to have_content("Não foi possivel criar a aula, preencha todos os campos")

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
        
        visit root_path
        click_on 'Cursos'
        click_on "#{course.name}"
        click_on  'Registrar Aula'
        click_on 'Voltar'

        expect(current_path).to eq course_path(course)
      end
end