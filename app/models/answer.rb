class Answer < ActiveRecord::Base
  validates :body, presence: :true, length: { in: 10..2048 }
  belongs_to :question, dependent: :destroy
end