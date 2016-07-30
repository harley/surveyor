class CollaborationsController < ApplicationController
  before_action :authorize

  def index
    load_survey_form
  end

  def new
    load_survey_form
    build_collaboration_form
  end

  def create
    load_survey_form
    @collaboration = @survey.collaborations.build collaboration_params
    if @collaboration.save!
      redirect_to survey_collaborations_path(@survey)
    else
      render 'new', notice: "Please correct errors below."
    end
  end

  private

  def load_survey_form
    @survey = Survey.find params[:survey_id]
  end

  def build_collaboration_form
    @collaboration = Collaboration.new
    @collaboration.survey = @survey
  end

  def collaboration_params
    params.require(:collaboration).permit(:user_id, :role)
  end
end