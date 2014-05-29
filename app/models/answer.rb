class Answer < ActiveRecord::Base
  validates :body, presence: :true, length: { in: 10..2048 }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy

  accepts_nested_attributes_for :attachments
  default_scope { order('created_at') }
end