class AccessibleSurveys
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def surveys
    if user.admin?
      Survey.all
    elsif user
      Survey.where(id: Collaboration.select("survey_id").where("user_id = ?", user.id))
    else
      []
    end
  end
end