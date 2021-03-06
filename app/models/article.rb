class Article < ActiveRecord::Base
  resourcify

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5, maximum: 80 }
  validates :title, uniqueness: true, uniqueness: { message: "This article title has already been posted."}
  validates :body, length: { minimum: 15 }
end
