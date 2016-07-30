class Permission < Struct.new(:user)
  delegate :role, to: :user, prefix: false

  LOOKUP = {
    "admin" => %w(surveys#all responses#all collaborations#all),
    "user" => %w(surveys#new surveys#create surveys#edit surveys#update surveys#show),
    "owner" => %w(surveys#new surveys#create),
    "viewer" => ["surveys#show"],
    "editor" => ["surveys#edit"],
    "visitor" => ["surveys#show"]
  }
  def allow?(controller, action)
    right = "#{controller}##{action}"
    all_rights = "#{controller}#all"
    god = "all#all"
    LOOKUP[role] &&
      (
        LOOKUP[role].include?(right) ||
        LOOKUP[role].include?(all_rights) ||
        LOOKUP[role].include?(god)
      )
  end
end
