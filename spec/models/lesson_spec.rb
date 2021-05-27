# spec/models/lesson_spec.rb

require 'rails_helper'

describe Lesson do
  context 'validation' do
    it 'attributes cannot be blank' do
     lesson = Lesson.new

      lesson.valid?

      expect(lesson.errors[:name]).to include('não pode ficar em branco')
      expect(lesson.errors[:description]).to include('não pode ficar em branco')
      expect(lesson.errors[:duration]).to include("não pode ficar em branco")

    end

    it 'greater than 0' do
      instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')
      
      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    instructor: instructor,
                    enrollment_deadline: '22/12/2033')
      course = Course.new(code: 'RUBYBASIC')

      lesson = Lesson.new(name: 'Aula 1',
                                        description: 'A primeira aula do curso',
                                        duration: 0)

      lesson.valid?

      expect(lesson.errors[:duration]).to include('deve ser maior que 0')
    end
  end
end