#admin_delete_instructors_spec.rb

require 'rails_helper'

describe 'Admin delete instructors' do
  it 'successfully' do
    Instructor.create!(name: 'João', email: 'joao@gmail.com', bio: 'lerolerolerolero')
    
    visit root_path
    click_on 'Professores'
    click_on 'João'
    click_on 'Excluir'
  end
end