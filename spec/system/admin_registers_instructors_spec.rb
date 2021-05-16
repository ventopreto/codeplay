# spec/system/admin_registers_instructors_spec.rb

require 'rails_helper'

describe 'Admin update instructors' do
  it 'successfully' do

    Instructor.create!(name: 'João', email: 'joao@gmail.com',
                   bio: 'lerolerolero')

    visit root_path
    click_on 'Professor'
    click_on 'João'
    click_on 'Editar'

    fill_in 'Nome', with: 'Luiz Carlos'
    fill_in 'Email', with: 'luiz@gmail.com'
    fill_in 'Biografia', with: 'lerolerolerolerolerolerolerolero'

    click_on 'Cadastrar Professor'

    expect(current_path).to eq(instructor_path(Instructor.last))
    expect(page).to have_content('Luiz Carlos')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('lerolerolerolerolerolerolerolero')
    expect(page).to have_link('Voltar')
  end

  it 'and update with blank fields' do

    visit root_path
    click_on 'Professor'
    click_on 'Registrar um Professor'
    click_on 'Cadastrar Professor'

    expect(page).to have_content("Você deve informar todos os dados do professor")
  end
end