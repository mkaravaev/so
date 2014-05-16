class Tag < ActiveRecord::Base
  validates :name, presence: :true, length: { maximum: 20 }, uniqueness: true
  belongs_to :question
end