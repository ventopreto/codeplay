class Course < ApplicationRecord
  validates :name, :code, :price, presence: true
  validates :code, uniqueness: true
  belongs_to :instructor
  has_many :lessons
  has_many :orders
  has_many :students, through: :orders



  scope :available, -> {where("enrollment_deadline >= ?", Date.current)}
  scope :not_draft, -> {where(status:1)}
  enum status: { Rascunho: 0, Publicado: 1}
end

