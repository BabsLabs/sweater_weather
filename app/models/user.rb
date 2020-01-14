class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_confirmation, require: true, length: { minimum: 1 }
end
