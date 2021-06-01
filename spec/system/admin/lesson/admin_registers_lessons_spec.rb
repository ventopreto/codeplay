#spec/system/admin_registers_lessons_spec.rb

describe 'admin registers lesson' do
  it 'successfully' do
    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course =  Course.create(name: 'Introdução a ciencias da computação com python',
                        description: 'Um curso sobre python',
                        code: 'PYTHONCODE',
                        instructor: instructor,
                        price: '0800',
                        enrollment_deadline: '22/12/2033')
                        
          login_as user, scope: :user   
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

    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    instructor = Instructor.create!(name: 'Fulano Sicrano',
    email: 'fulano@codeplay.com.br')

    course =  Course.create(name: 'Introdução a ciencias da computação com python',
                              description: 'Um curso sobre python',
                              code: 'PYTHONCODE',
                              instructor: instructor,
                              price: '0800',
                              enrollment_deadline: '22/12/2033')

        visit root_path
        click_on 'Logar'
        fill_in 'Email', with: 'x@gmail.com'
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
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
        user = User.create!(email: 'x@gmail.com',
        password: '123456')

        instructor = Instructor.create!(name: 'Fulano Sicrano',
        email: 'fulano@codeplay.com.br')
    
        course =  Course.create(name: 'Introdução a ciencias da computação com python',
                                  description: 'Um curso sobre python',
                                  code: 'PYTHONCODE',
                                  instructor: instructor,
                                  price: '0800',
                                  enrollment_deadline: '22/12/2033')
        
        visit root_path
        click_on 'Logar'
        fill_in 'Email', with: 'x@gmail.com'
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
        click_on 'Cursos'
        click_on "#{course.name}"
        click_on  'Registrar Aula'
        click_on 'Voltar'

        expect(current_path).to eq course_path(course)
      end
end