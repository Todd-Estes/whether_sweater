class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true


  has_secure_token :api_key

  has_secure_password

  # user = User.new
  # user.save
  # user.api_key
  # user.regenerate_api_key
end
