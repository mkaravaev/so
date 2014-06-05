class Comment < ActiveRecord::Base
  validates :body, presence: :true
  validates :user_id, presence: :true
  validates :body,  length: { in: 3..256 }
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  default_scope { order('created_at') }
end
