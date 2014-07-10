class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :url
  has_many :answers
  has_many :comments
  has_many :attachments
end
