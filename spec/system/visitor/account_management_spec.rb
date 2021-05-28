require 'rails_helper'

describe 'Visitor creates account' do
   it 'with email and password' do
     visit root_path
     click_on 'Registrar-me'
     fill_in 'Email', with: 'fulano@gmail.com'
     fill_in 'Senha', with: '123456'
     fill_in 'Confirmação de senha', with: '123456'
     click_on 'Criar conta'

     expect(page).to have_text('Login efetuado com sucesso')
     expect(page).to have_text('fulano@gmail.com')
     expect(current_path).to eq(root_path)
     expect(page).to_not have_link('Registrar-me')
     expect(page).to have_link('Sair')
   end

   it 'without valid field' do
    visit root_path
    click_on 'Registrar-me'
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmação de senha', with: ''
    click_on 'Criar conta'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
 

   end

   it 'password not match confirmation' do
    visit root_path
    click_on 'Registrar-me'
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '654321'
    click_on 'Criar conta'

    expect(page).to have_content('Confirmação de senha não é igual a Senha')
   end

   it 'with email not unique' do
    User.create!(email: 'x@gmail.com',
                        password: '123456')

    visit root_path
    click_on 'Registrar-me'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_content('Email já está em uso')
   end


   context 'sign in' do
    it 'with email and password' do
    User.create!(email: 'x@gmail.com', password: '123456')
    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('x@gmail.com')
    expect(current_path).to eq(root_path)
    expect(page).to_not have_link('Registrar-me')
    expect(page).to_not have_link('Entrar')
    expect(page).to have_link('Sair')
   end

   context 'logout' do
    it 'successfully' do
      user = User.create!(email: 'x@gmail.com',
                                      password: '123456')
      
      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('x@gmail.com')
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Registrar-me')
      expect(page).to have_link('Logar')
      expect(page).to_not have_link('Sair')
    end
   end
  end
end