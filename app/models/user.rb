class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true

  def role
    admin? ? 'admin' : 'user'
  end

  def visitor?
    false
  end
end
