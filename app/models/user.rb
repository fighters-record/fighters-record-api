# app/models/user.rb
class User < ApplicationRecord
  has_secure_password # ← これでpassword/confirmation/validationが使える

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_digest_changed?
end
