# spec/system/admin_view_instructors_spec.rb

require 'rails_helper'

describe 'Admin view instructors' do
  it 'successfully' do
    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
                   bio: 'seilaksahkhashk')
    Instructor.create!(name: 'Luiz', email: 'luiz@gmail.com',
                   bio: 'pkfjghikdfkgh')

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Julio')
    expect(page).to have_content('Luiz')

  end

  it 'and view details' do
    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
                   bio: 'seilaksahkhashk')
    Instructor.create!(name: 'Luiz', email: 'luiz@gmail.com',
                   bio: 'pkfjghikdfkgh')

    visit root_path
    click_on 'Professores'
    click_on 'Luiz'

    expect(page).to have_content('Luiz')
    expect(page).to have_content('luiz@gmail.com')
    expect(page).to have_content('pkfjghikdfkgh')
  end

  it 'and no course is available' do
    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Nenhum professor disponível')
  end

  it 'and return to home page' do
    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    visit root_path
    click_on 'Professores'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it 'and return to promotions page' do
    Instructor.create!(name: 'Julio', email: 'julio@gmail.com',
    bio: 'seilaksahkhashk')

    visit root_path
    click_on 'Professores'
    click_on 'Julio'
    click_on 'Voltar'

    expect(current_path).to eq instructors_path

  end
end