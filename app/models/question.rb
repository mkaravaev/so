class Question < ActiveRecord::Base

  validates :title, :body, presence: :true
  validates :title, length: { in: 7..180 }
  validates :body,  length: { in: 10..2048 }

  has_many :tags_questions
  has_many :tags, through: :tags_questions
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :tags


  def tag_names
    tags.pluck(:name)
  end

  def tag_names=(names)
    self.tags = names.split(",").map { |name| Tag.where(name: name).first_or_create! }
  end
end