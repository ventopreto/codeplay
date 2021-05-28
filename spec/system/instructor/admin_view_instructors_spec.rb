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


    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
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
                              profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/instructor.png')))

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professores'
    click_on 'Luiz'


    expect(page).to have_content('Luiz')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('pkfjghikdfkgh')
  end

  it 'and no instructor is available' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor disponível')
  end

  it 'and return to home page' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to index page' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professores'
    click_on 'Julio'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path

  end
end