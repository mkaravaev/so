class Subscription < ActiveRecord::Base

  belongs_to :subscriber, class_name: 'User'
  belongs_to :resource, class_name: 'Question'

  validates :subscriber_id, presence: true
  validates :resource_id, presence: true

  def add_subscription()
    self.create()
  end
end
