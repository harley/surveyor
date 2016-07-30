class SurveyPermission
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def allow?(survey: survey, user: user)
    false
  end
end