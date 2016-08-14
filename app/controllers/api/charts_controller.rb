class Api::ChartsController < ApplicationController
  def grouped_answers
    question = Question.find params[:question_id]
    render json: question.answers.group(:content).count
  end

  def sorted_grouped_answers
    question = Question.find params[:question_id]
    render json: question.answers.group(:content).count.to_a.sort_by(&:last).reverse.to_h
  end
end
