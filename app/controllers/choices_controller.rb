class ChoicesController < ApplicationController
  def destroy
    choice = Choice.find params[:id]
    survey = choice.survey
    choice.destroy
    respond_to do |format|
      format.html { redirect_to edit_survey_path(survey) }
      format.js do
        @form = SurveyForm.new survey
        @form.prepopulate!
        render template: 'surveys/update'
      end
    end
  end
end
