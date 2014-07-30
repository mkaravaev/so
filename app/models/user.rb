class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :authorizations
  has_many :subscriptions, foreign_key: "subscriber_id", dependent: :destroy
  has_many :followed_resources, through: :subscriptions, source: :resource
  
  has_one  :reputation

  validate :name, presence: :true, uniqueness: true, length: { in: 3..30 } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    
    auth.info[:email] ? email = auth.info[:email] : email = "#{SecureRandom.urlsafe_base64(10)}" + "@soclon.com"
    # TODO add user name to if user from twitter
    user = User.where(email: email).first

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

  def self.send_daily_digest
    find_each.each do |user|
      DailyMailer.delay.digest(user)
    end
  end

  def subscribed?(question)
    self.subscriptions.where(subscriber_id: self, resource_id: question)
  end

end
