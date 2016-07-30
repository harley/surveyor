class NullUser
  attr_reader :role

  def initialize(role = "visitor")
    @role = role
  end
end