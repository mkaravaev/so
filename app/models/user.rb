class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  validate :name, presence: :true, uniqueness: true, length: { in: 3..30 } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
