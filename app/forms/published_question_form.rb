class PublishedQuestionForm < Reform::Form
  property :title
  property :type

  collection :choices,
    prepopulator: :set_up_choices,
    populate_if_empty: Choice,
    skip_if: :skip_blank_choices do
    property :content
  end

  def skip_blank_choices(options)
    options[:fragment]['content'].blank?
  end

  def set_up_choices(options)
    self.choices << Choice.new if choices.empty?
  end
end
