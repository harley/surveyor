class Permission < Struct.new(:user)
  LOOKUP = {
    "admin" => ["surveys#new", "surveys#create", "surveys#edit", "surveys#update", "surveys#destroy"],
    "user" => ["surveys#new", "surveys#create"]
  }
  def allow?(controller, action)
    right = "#{controller}##{action}"
    LOOKUP[user.role] && LOOKUP[user.role].include?(right)
  end
end
