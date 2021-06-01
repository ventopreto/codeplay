#admin_delete_instructors_spec.rb

require 'rails_helper'

describe 'Admin delete instructors' do
  it 'successfully' do
    
    user = User.create!(email: 'x@gmail.com',
    password: '123456')
    Instructor.create!(name: 'João', email: 'joao@gmail.com', bio: 'lerolerolerolero')
    
    visit root_path
    click_on 'Logar'
    fill_in 'Email', with: 'x@gmail.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    click_on 'Professores'
    click_on 'João'
    expect {click_on 'Deletar Professor'}.to change {Instructor.count}.by(-1)
    expect(page).to have_content('Professor removido com sucesso')
  end
end