class PublishedSurveyForm < Reform::Form
  property :title

  collection :questions,
    skip_if: :skip_blank_questions,
    form: PublishedQuestionForm,
    prepopulator: :set_up_questions,
    populate_if_empty: Question

  def skip_blank_questions(options)
    options[:fragment]['title'].blank?
  end

  def set_up_questions(options)
    self.questions
  end
end
