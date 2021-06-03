# spec/system/admin_updates_instructors_spec.rb

require 'rails_helper'

describe 'Admin updates instructors' do
  it 'successfully' do

    Instructor.create!(name: 'João', email: 'joao@gmail.com',
                   bio: 'lerolerolero')

    user_login
    visit root_path
    click_on 'Professor'
    click_on 'João'
    click_on 'Editar'

    fill_in 'Nome', with: 'Luiz Carlos'
    fill_in 'Email', with: 'luiz@gmail.com'
    fill_in 'Descrição', with: 'lerolerolerolerolerolerolerolero'

    click_on 'Atualizar Professor'

    expect(current_path).to eq(admin_instructor_path(Instructor.last))
    expect(page).to have_content('Luiz Carlos')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('lerolerolerolerolerolerolerolero')
    expect(page).to have_link('Voltar')
  end

  it 'and update with blank fields' do

    professor = Instructor.create!(name: 'João', email: 'joao@gmail.com',
    bio: 'lerolerolero')

    user_login
    visit root_path
    click_on 'Professor'
    click_on "#{professor.name}"
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    click_on 'Atualizar Professor'

    expect(page).to have_content("Você deve informar todos os dados do professor")
  end

  it 'must be logged in to visit instructor edit page throgh routes' do
    instructor = Instructor.create!(name: 'João', email: 'joao@gmail.com',
    bio: 'lerolerolero')

    visit edit_admin_instructor_path(instructor)

    expect(current_path).to eq(new_user_session_path)
  end

  xit 'cannot access edit form without login' do

    instructor = Instructor.create!(name: 'João', email: 'joao@gmail.com',
    bio: 'lerolerolero', profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/files/instructor.png')))
 
     professor = Instructor.create!(name: 'Luiz',
    email: 'luiz@gmail.com',
    bio: 'pkfjghikdfkgh', profile_picture: 1)


    patch admin_instructor_path(professor)
    expect(current_path).to redirect_to(new_user_session_path)
  end
end