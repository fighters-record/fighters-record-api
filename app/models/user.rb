# app/models/user.rb
class User < ApplicationRecord
  has_secure_password # ← これでpassword/confirmation/validationが使える
  validates :email, presence: true, uniqueness: true
end
