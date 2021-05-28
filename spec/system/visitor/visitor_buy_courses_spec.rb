require 'rails_helper'

describe 'Visitor Buy Courses' do
  it 'successfully' do
    
    visit root_path
    click_on 'Comprar cursos'

  end
end