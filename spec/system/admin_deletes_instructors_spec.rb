#admin_delete_instructors_spec.rb

require 'rails_helper'

describe 'Admin delete instructors' do
  it 'successfully' do
    Instructor.create!(name: 'João', email: 'joao@gmail.com', bio: 'lerolerolerolero')
    
    visit root_path
    click_on 'Professores'
    click_on 'João'
    expect {click_on 'Deletar'}.to change {Instructor.count}.by(-1)
    expect(page).to have_content('Professor removido com sucesso')
  end
end