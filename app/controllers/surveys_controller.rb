class SurveysController < ApplicationController
  def new
    build_survey_form
  end

  def show
    redirect_to action: 'edit'
  end

  def create
    build_survey_form
    if @form.save
      redirect_to edit_survey_path(@form)
    else
      render 'new'
    end
  end

  def edit
    load_survey_form
    @form.prepopulate!
  end

  def update
    load_survey_form
    if params[:add_question]
      @add_question_count = params[:add_question_count].to_i
      @add_question_count += 1
      @add_question_count.times do
        @form.questions << Question.new
      end
      @form.prepopulate!
      render 'edit'
    else
      if @form.validate survey_params
        @form.save
        redirect_to edit_survey_path, notice: "Saved."
      else
        @form.prepopulate!
        render 'edit'
      end
    end
  end

  def published
    survey = Survey.find params[:id]
    @form = PublishedSurveyForm.new survey
    @form.prepopulate!
    render 'surveys/published/published'
  end

  private

  def survey_params
    params.require(:survey).permit(:title, questions_attributes: [:title, :type, choices_attributes: [:content]]) if params[:survey]
  end

  def build_survey_form
    survey = Survey.new survey_params
    @form = SurveyForm.new survey
  end

  def load_survey_form
    survey = Survey.find params[:id]
    @form = SurveyForm.new survey
  end
end
