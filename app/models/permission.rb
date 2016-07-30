class Permission < Struct.new(:user)
  delegate :role, to: :user, prefix: false

  LOOKUP = {
    "admin" => ["surveys#new", "surveys#create", "surveys#edit", "surveys#update", "surveys#destroy", "surveys#show"],
    "user" => ["surveys#new", "surveys#create", "surveys#edit", "surveys#update", "surveys#show"],
    "owner" => ["surveys#new", "surveys#create"],
    "viewer" => ["surveys#show"],
    "editor" => ["surveys#edit"],
    "visitor" => ["surveys#show"]
  }
  def allow?(controller, action)
    right = "#{controller}##{action}"
    LOOKUP[role] && LOOKUP[role].include?(right)
  end
end
