class UserPassword < ApplicationRecord
  ROLES = %w[owner viewer editor]

  belongs_to :user
  belongs_to :password

  validates :role, presence: true, inclusion: { in: ROLES }

  attribute :role, default: :viewer

  def has_edit_permissions?
    role == "owner" || role == "editor"
  end

  def has_owner_permissions?
    role == "owner"
  end
end
