class Permission < Struct.new(:user)
  LOOKUP = {
    "admin" => ["surveys#new", "surveys#create", "surveys#edit", "surveys#update", "surveys#destroy"],
    "user" => ["surveys#new", "surveys#create"],
    "owner" => ["surveys#new", "surveys#create"],
    "viewer" => ["surveys#show"],
    "editor" => ["surveys#edit"],
    "guest" => []
  }
  def allow?(controller, action)
    right = "#{controller}##{action}"
    LOOKUP[role] && LOOKUP[role].include?(right)
  end

  private

  def role
    user.try(:role) || "guest"
  end
end
