class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_one_attached :avatar

  enum role: ["user", "moderator", "admin"]

  # enum role: [:user, :moderator, :admin]

  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.from_omniauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    #byebug
    if user.present?
      user
    else

      # Check wether theres is already a user with the same
      # email address
      user_with_email = User.find_by_email(auth.info.email)

      if user_with_email.present?
        user = user_with_email
      else
        user = User.new

        if auth.provider == "facebook"
          user.provider = auth.provider
          user.uid = auth.uid
          user.oauth_token = auth.credentials.token

          user.first_name = auth.extra.raw_info.first_name
          user.last_name = auth.extra.raw_info.last_name
          user.email = auth.extra.raw_info.email
          user.image = auth.info.image

          # Facebook's token doesn't last forever
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          #byebug
          user.save!
        else auth.provider == "google_oauth2"
          user.provider = auth.provider
          user.uid = auth.uid
          user.oauth_token = auth.credentials.token
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
          user.image = auth.info.image
          
 # Google's token doesn't last forever
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          user.save!         end
      end
    end
    return user
  end

  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"], without_protection: true) do |user|
  #       user.attributes = params
  #       user.valid?
  #     end
  #   else
  #     super
  #   end
  # end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end
end
