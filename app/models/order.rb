class Order < ApplicationRecord
  belongs_to :course
  belongs_to :student
end
