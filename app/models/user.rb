class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,    #:validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  # validates_uniqueness_of :username

  has_many :articles
  has_many :comments

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://s3.amazonaws.com/essentials-roy/6-go-to-biker.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      binding.pry
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.oauth_token = auth.credentials.token
      user.username = auth.info.name
      user.name = auth.info.name
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      user.save!
      user
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
