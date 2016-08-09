class SurveyEditPermission
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def allow?(resource)
    return false unless resource
    return true if user.admin?
    return Collaboration.exists?(user: user, survey: resource, role: [Collaboration.roles[:owner], Collaboration.roles[:editor]])
  end
end