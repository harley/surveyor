class ResponsesController < ApplicationController
  def index
    load_survey
    @responses = @survey.responses.page(params[:page]).per(params[:per])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    load_survey
  end

  def create
    load_survey
    @response = @survey.responses.build response_params
    if @response.save
      redirect_to edit_survey_response_path(@survey, @response)
    else
      render 'new', notice: "Please correct errors below."
    end
  end

  def edit
    load_survey
    response = Response.find params[:id]
    @form = ResponseForm.new(response)
    @form.prepopulate!
  end

  def update
    load_survey
    response = Response.find params[:id]
    @form = ResponseForm.new(response)
    if @form.validate params[:response].to_hash
      @form.save
      redirect_to root_path, notice: "Thank you!"
    else
      render 'edit'
    end
  end

  private
  def load_survey
    @survey = Survey.find params[:survey_id]
  end

  def response_params
    # TODO update permit to work with ResponseQuestion
    # "response"=>
    #   {"questions"=>
    #     {"1"=>{"answers"=>{"id"=>"3", "question_id"=>"1", "choice_id"=>"4", "content"=>"i'm a creep"}},
    #      "2"=>{"answers"=>{"id"=>"", "question_id"=>"2", "choice_id"=>"5", "content"=>"red"}}}},
    params.require(:response).permit! if params[:response]
  end
end
