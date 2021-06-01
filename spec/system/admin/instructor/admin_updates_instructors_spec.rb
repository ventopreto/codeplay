# spec/system/admin_updates_instructors_spec.rb

require 'rails_helper'

describe 'Admin updates instructors' do
  it 'successfully' do
    user = User.create!(email: 'x@gmail.com',
                                    password: '123456')

    Instructor.create!(name: 'João', email: 'joao@gmail.com',
                   bio: 'lerolerolero')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
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
    user = User.create!(email: 'x@gmail.com',
    password: '123456')

    professor = Instructor.create!(name: 'João', email: 'joao@gmail.com',
    bio: 'lerolerolero')

    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professor'
    click_on "#{professor.name}"
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    click_on 'Atualizar Professor'

    expect(page).to have_content("Você deve informar todos os dados do professor")
  end
end