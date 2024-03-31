class Password < ApplicationRecord

  has_many :user_passwords, dependent: :destroy
  has_many :users, through: :user_passwords

  encrypts :username, deterministic: true
  encrypts :password

  validates :url, presence: true
  validates :password, presence: true
  validates :username, presence: true

  def editable_by?(user)
    user_password = user_passwords.find_by(user: user)
    user_password.has_edit_permissions?
  end

  def owned_by?(user)
    user_password = user_passwords.find_by(user: user)
    user_password.has_owner_permissions?
  end
end
