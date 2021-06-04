# spec/system/admin_view_instructors_spec.rb

require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    Instructor.create!(name: 'Julio',
                                email: 'julio@gmail.com',
                                bio: 'seilaksahkhashk')
    Instructor.create!(name: 'Luiz',
                                email: 'luiz@gmail.com',
                                bio: 'pkfjghikdfkgh')

    login_as user, scope: :user
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Julio')
    expect(page).to have_content('Luiz')

  end

  it 'and view details' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

  Instructor.create!(name: 'Luiz',
                              email: 'luiz@gmail.com',
                              bio: 'pkfjghikdfkgh',
                              profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/files/instructor.png')))
    login_as user, scope: :user
    visit root_path
    click_on 'Professores'
    click_on 'Luiz'


    expect(page).to have_content('Luiz')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('pkfjghikdfkgh')
  end

  it 'and no instructor is available' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor disponível')
  end

  it 'and return to home page' do


    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end

  it 'and return to index page' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    login_as user, scope: :user
    visit root_path
    click_on 'Professores'
    click_on 'Julio'
    click_on 'Voltar'

    expect(current_path).to eq admin_instructors_path

  end

  it 'must be logged in to view instructor details through route' do
   instructor = Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    visit admin_instructor_path(instructor)

    expect(current_path).to eq(new_user_session_path)
  end

  it 'must be logged in to view instructors through route' do
    visit admin_instructors_path

    expect(current_path).to eq(new_user_session_path)
  end
end