require 'rails_helper'

describe 'Student view courses on homepage' do
  it 'courses with enrollment still available' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                            code: 'RUBYBASIC', price: 10,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)

  unavailable_course = Course.create!(name: 'HTML', description: 'Um curso de html',
                                                          code: 'HTMLBASIC', price: 12,
                                                          enrollment_deadline: 2.day.ago, instructor: instructor)

    visit root_path
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('HTML')
    expect(page).to_not have_content('Um curso de html')
    expect(page).to_not have_content('R$ 12,00')
  end
  it 'and view enrollment link' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                            code: 'RUBYBASIC', price: 10,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    login_as user, scope: :user                                                      
    visit root_path
    click_on 'Ruby'

    expect(page).to have_link 'Comprar'
  end

  it 'and does not view orders if deadline is over' do
    #curso com data limite ultrapassada, mas com usuario logado, não deve exibir o link
      user = User.create!(email: 'jane@test.com.br', password: '123456')
      instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                      email: 'fulano@codeplay.com.br')
      available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                              code: 'RUBYBASIC', price: 10,
                                                              enrollment_deadline: 1.month.from_now, instructor: instructor)
    unavailable_course = Course.create!(name: 'HTML', description: 'Um curso de html',
                                                              code: 'HTMLBASIC', price: 12,
                                                              enrollment_deadline: 2.day.ago, instructor: instructor)
      login_as user, scope: :user                                                      
      visit root_path

      expect(page).to_not have_content('HTML')
      expect(page).to_not have_content('Um curso de html')
  end

  it 'must be signed in to order' do

      instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                      email: 'fulano@codeplay.com.br')
      available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                              code: 'RUBYBASIC', price: 10,
                                                              enrollment_deadline: 1.month.from_now, instructor: instructor)                                              
      visit root_path
      click_on 'Ruby'
      expect(page).to have_content 'Faça login para comprar esse curso'
      expect(page).to have_link 'login', href: new_user_session_path
  end

  it ' and buy a course' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                            code: 'RUBYBASIC', price: 10,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
  other_course = Course.create!(name: 'Elixir', description: 'Um curso de elixir',
                                                            code: 'ELIXIRBASIC', price: 20,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    login_as user, scope: :user                                                      
    visit root_path
    click_on 'Ruby'
    click_on 'Comprar'

    expect(page).to have_content('Curso comprado com sucesso')
    expect(page).to_not have_link('Comprar')
    expect(current_path).to eq(my_courses_courses_path)
    expect(page).to have_content('Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('Elixir')
    expect(page).to_not have_content('R$ 20,00')
  end
  it ' and cannot buy a course twice' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                            code: 'RUBYBASIC', price: 10,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
                                  Lesson.create!(name: 'Monkey Patch', description: 'Blablabla', course: available_course, duration: 40)
  other_course = Course.create!(name: 'Elixir', description: 'Um curso de elixir',
                                                            code: 'ELIXIRBASIC', price: 20,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
                            Order.create!(user: user, course: available_course)
    login_as user, scope: :user                                                      
    visit root_path
    click_on 'Ruby'
    click_on 'Ver Aulas'

    expect(page).to_not have_link('Comprar')
    expect(page).to have_link('Monkey Patch')

  end
  xit 'and cannot view lesson without buy' do
    user = User.create!(email: 'jane@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                                    email: 'fulano@codeplay.com.br')
    available_course = Course.create!(name: 'Ruby', description: 'Um curso de ruby',
                                                            code: 'RUBYBASIC', price: 10,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
                                  Lesson.create!(name: 'Monkey Patch', description: 'Blablabla', course: available_course, duration: 40)
  other_course = Course.create!(name: 'Elixir', description: 'Um curso de elixir',
                                                            code: 'ELIXIRBASIC', price: 20,
                                                            enrollment_deadline: 1.month.from_now, instructor: instructor)
    login_as user, scope: :user                                                      
    visit courses_path

    expect(page).to_not have_content('Ruby')
    expect(page).to_not have_content('Um curso de ruby')
    expect(page).to_not have_content('Elixir')
    expect(page).to_not have_content('Um curso de elixir')
    
  end
end