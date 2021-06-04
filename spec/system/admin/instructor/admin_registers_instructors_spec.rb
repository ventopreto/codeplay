# spec/system/admin_registers_instructors_spec.rb

require 'rails_helper'

describe 'Admin registers instructors' do

  it 'successfully' do


    user_login
    visit root_path
    click_on 'Professor'
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Luiz Carlos'
    fill_in 'Email', with: 'luiz@gmail.com'
    fill_in 'Descrição', with: 'lerolerolerolerolerolerolerolero'

    click_on 'Cadastrar Professor'

    expect(current_path).to eq(admin_instructor_path(Instructor.last))
    expect(page).to have_content('Luiz Carlos')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('lerolerolerolerolerolerolerolero')

    expect(page).to have_link('Voltar')
  end

  it 'and create with blank fields' do

    user_login
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'
    click_on 'Cadastrar Professor'

    expect(page).to have_content("Você deve informar todos os dados do professor")
  end

  it 'must be logged visit instructor registration page through route' do

    visit new_admin_instructor_path

    expect(current_path).to eq(new_user_session_path)
    
  end
end