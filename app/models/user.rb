class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2] #,omniauth_providers => [:google_oauth2]
         #,authentication_keys: [:login]


  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'  
  has_many :followers, through: :following_users

  has_many :likes, through: :posts
  has_many :comments, through: :posts
  has_many :votes, through: :posts
  acts_as_voter

  # attr_writer :login

  # def login
  #   @login || self.username || self.email
  # end

  #attr_accessor :login

  #validates :user_name, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["user_name = :value OR lower(email) = lower(:value)", { :value => login }]).first
  #   elsif conditions.has_key?(:user_name) || conditions.has_key?(:email)
  #     where(conditions.to_h).first
  #   end
  # end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data[“email”] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
  end
  end  
end