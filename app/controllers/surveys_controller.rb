class SurveysController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @surveys = Survey.all
  end

  def new
    build_survey_form
  end

  def show
    redirect_to new_survey_response_path(params[:id])
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
    authorize controller_name, action_name
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
        redirect_to edit_survey_path(@form), notice: "Saved."
      else
        @form.prepopulate!
        render 'edit'
      end
    end
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
