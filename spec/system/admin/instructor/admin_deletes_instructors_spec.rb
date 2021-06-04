#admin_delete_instructors_spec.rb

require 'rails_helper'

describe 'Admin delete instructors' do
  it 'successfully' do
    
    Instructor.create!(name: 'João', email: 'joao@gmail.com', bio: 'lerolerolerolero')
    
    user_login
    visit root_path
    click_on 'Professores'
    click_on 'João'
    expect {click_on 'Deletar Professor'}.to change {Instructor.count}.by(-1)
    expect(page).to have_content('Professor removido com sucesso')
  end

  it 'cannot delete instructor without login' do
    instructor = Instructor.create!(name: 'João', email: 'joao@gmail.com',
    bio: 'lerolerolero')

    delete admin_instructor_path(instructor)

    expect(response).to redirect_to(new_user_session_path)
  end
end