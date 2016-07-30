class QuestionsController < ApplicationController
  before_action :authorize

  def destroy
    @question = Question.find params[:id]
    @question.destroy
    redirect_back fallback_location: root_path
  end
end
