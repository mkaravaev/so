class Question < ActiveRecord::Base

  validates :title, :body, presence: :true
  validates :title, length: { in: 7..180 }
  validates :body,  length: { in: 10..2048 }

  after_create :calculate_reputation

  has_many :tags_questions
  has_many :tags, through: :tags_questions
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  belongs_to :user

  has_many :subscriptions, foreign_key: "resource_id", dependent: :destroy
  has_many :subscribers, through: :subscriptions

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :tags


  scope :for_day, -> { where (["created_at >= ?", Time.now - 24.hours]) }

  def tag_names
    tags.pluck(:name).each { |tag| tag.gsub(/[\[\]]/) } if self.tags.exists?
  end

  def tag_names=(names)
    self.tags = names.split(",").map { |name| Tag.where(name: name).first_or_create! }
  end

  def subscribe(user)
    Subscription.create!(subscriber: user, resource: self)
  end

  def unsubscribe(user)
    subscription = Subscription.where(subscriber: user, resource: self).last
    subscription.try(:destroy)
  end

  private

  def calculate_reputation
    reputation = Reputation.calculate(self)
    self.user.update(reputation: reputation)
  end
end
