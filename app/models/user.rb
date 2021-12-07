class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: { case_sensitive: false, message: "Este usuario ya se encuentra registrado" }
  validates :email, uniqueness: { case_sensitive: false, message: "Este email ya se encuentra registrado" }, allow_blank: true
end
