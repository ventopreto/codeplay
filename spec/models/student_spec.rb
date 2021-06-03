require 'rails_helper'

describe Student do
  context 'validation' do
    it 'attributes cannot be blank' do
      student = Student.new
      student.valid?

      expect(student.errors[:email]).to include('não pode ficar em branco')
      expect(student.errors[:password]).to include('não pode ficar em branco')
    end

    it 'email must be unique' do
      Student.create!(email: 'fulano@codeplay.com.br',
                                      password: '123456')

      student = Student.create(email: 'fulano@codeplay.com.br')

      student.valid?

      expect(student.errors[:email]).to include('já está em uso')
    end
  end
end
