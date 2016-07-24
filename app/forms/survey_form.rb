class SurveyForm < Reform::Form
  property :title
  validates :title, presence: true

  collection :questions,
             skip_if: :skip_blank_questions,
             form: QuestionForm,
             prepopulator: :set_up_questions,
             populator: :populate_question

  def populate_question(collection:, index:, fragment:, **a)
    if item = collection[index]
      item
    else
      q = Question.new(fragment)
      q.choices << Choice.new
      collection.insert(index, q)
      QuestionForm.new(q)
    end
  end

  def skip_blank_questions(options)
    options[:fragment]['title'].blank?
  end

  def set_up_questions(options)
    self.questions << Question.new if questions.size < 1
  end
end
