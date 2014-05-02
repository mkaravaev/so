class Question < ActiveRecord::Base
  validates :title, :body, presence: :true
  validates :title, length: { in: 7..180 }
  validates :body,  length: { in: 10..2048 }
  has_many :answers
end