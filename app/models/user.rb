class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
end
