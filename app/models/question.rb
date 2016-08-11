class Question < ApplicationRecord
  belongs_to :survey
  has_many :choices, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :title, presence: true
  QUESTION_TYPES = [:short_answer, :multiple_choice, :check_boxes]
  enum type: QUESTION_TYPES
  validates :type, inclusion: {in: types.keys }

  self.inheritance_column = nil

  def self.type_options
    keys = types.keys
    keys.map(&:humanize).zip keys
  end

  after_initialize do
    self.type ||= QUESTION_TYPES[0]
  end
end
