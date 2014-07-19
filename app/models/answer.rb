class Answer < ActiveRecord::Base
  validates :body, presence: :true, length: { in: 10..2048 }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :attachments
  # accepts_nested_attributes_for :comments, allow_destroy: true
  
  default_scope { order('created_at') }
  after_create :send_new_answer_notification
  after_create :calculate_rating

  def send_new_answer_notification
    AnswerMailer.delay.new_answer(self)
  end

  private

  def calculate_rating
    Reputation.calculate(self)
  end
end