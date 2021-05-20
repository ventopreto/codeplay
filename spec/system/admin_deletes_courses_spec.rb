# spec/system/admin_deletes_courses_spec

require 'rails_helper'

describe 'admin deletes courses' do
  it 'sucessfully' do

    Course.create!(name: 'Python',
                            description: 'Um curso de python',
                            code: 'PYTHONROCKS',
                            price: '350',
                            enrollment_deadline: '31/08/2022')

    visit root_path
    click_on 'Cursos'
    click_on 'Python'
    click_on 'Deletar'
  end
end