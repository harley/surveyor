class Collaboration < ApplicationRecord
  # we use the hash syntax instead of the array syntax for clarity
  # it also helps prevent accidental mistakes when reordering the roles
  enum role: {
      owner: 0, editor: 1, viewer: 2
  }

  def self.role_options
    keys = roles.keys
    keys.map(&:humanize).zip keys
  end

  belongs_to :survey
  belongs_to :user

  validates :role, inclusion: { in: roles.keys }
  validates :role, uniqueness: { scope: [:user_id, :survey_id], message: "already exists for user" }

  def email
    user.try(:email)
  end

  def self.owner(survey: survey, user: user)
    Collaboration.create(survey: survey, user: user, role: roles[:owner])
  end

  def self.editor(survey: survey, user: user)
    Collaboration.create(survey: survey, user: user, role: roles[:editor])
  end
end