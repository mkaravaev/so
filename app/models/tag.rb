class Tag < ActiveRecord::Base
  validates :name, presence: :true, length: { maximum: 20 }, uniqueness: true
  has_many :tags_questions
  has_many :questions, through: :tags_questions
end