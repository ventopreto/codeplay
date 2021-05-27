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

   xit 'without valid field' do
   end

   xit 'password not match confirmation' do
   end

   xit 'with email not unique' do
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
   end
  end
end