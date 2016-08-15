class Response < ApplicationRecord
  belongs_to :survey
  validates :survey, presence: true
  has_many :answers, dependent: :destroy

  def answers_for(question:, choice:)
    if filter = grouped_answers[question.id]
      filter.select{|e| e.choice == choice}
    end || []
  end

  def grouped_answers
    return @grouped_answers if @grouped_answers
    @grouped_answers = answers.group_by(&:question_id)
  end

  def previous
    survey.responses.where('id < ?', id).order('id DESC').first
  end

  def next
    survey.responses.where('id > ?', id).order('id').first
  end

  def offset_index
    survey.responses.where('id < ?', id).count + 1
  end
end
