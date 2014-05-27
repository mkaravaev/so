class Question < ActiveRecord::Base
  validates :title, :body, presence: :true
  validates :title, length: { in: 7..180 }
  validates :body,  length: { in: 10..2048 }

  has_many :tags
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :attachments
end