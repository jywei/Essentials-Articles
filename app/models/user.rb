class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :username

  has_many :articles
  has_many :comments

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://s3.amazonaws.com/essentials-roy/6-go-to-biker.jpg"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

end
