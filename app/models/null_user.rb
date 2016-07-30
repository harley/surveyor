class NullUser
  attr_reader :role

  def initialize(role = "visitor")
    @role = role
  end

  def admin?
    false
  end

  def id
    nil
  end

  def visitor?
    true
  end

  def email
    "Guest"
  end
end