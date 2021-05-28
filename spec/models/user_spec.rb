require 'rails_helper'

describe User do
  context 'validation' do
    it 'attributes cannot be blank' do
      user = User.new
      user.valid?

      expect(user.errors[:email]).to include('não pode ficar em branco')
      expect(user.errors[:password]).to include('não pode ficar em branco')
    end

    it 'email must be unique' do
      User.create!(email: 'fulano@codeplay.com.br',
                                      password: '123456')

      user = User.create(email: 'fulano@codeplay.com.br')

      user.valid?

      expect(user.errors[:email]).to include('já está em uso')
    end
  end
end
