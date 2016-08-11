class Survey < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :collaborations, dependent: :destroy

  validates :title, presence: true

  def responses_count
    responses.size
  end

  def last_response_at
    responses.order(updated_at: :desc).first.try(:updated_at)
  end

  def create_owner!(user)
    collaborations.create! user: user, role: :owner
  end

  def allow_collaboration?(user, action)
    if role = collaborations.find_by(user: user).try(:role)
      Collaboration::SURVEY_ACTIONS[role.to_sym].include?(action)
    end
  end

  def generate_response
    transaction do
      r = responses.create!
      questions.each do |q|
        puts "creaing answers for : #{q.type.inspect}"
        case q.type.to_sym
        when :short_answer
          c = q.choices.sample
          Answer.create! choice: c, question: q, response: r, content: Faker::Pokemon.name
        when :multiple_choice
          c = q.choices.sample
          Answer.create! choice: c, question: q, response: r, content: c.content
        when :check_boxes
          n = rand(q.choices.size)
          q.choices.shuffle[0...n].each do |c|
            Answer.create! choice: c, question: q, response: r, content: c.content
          end
        else
          raise "Error: #{q.type}"
        end
      end
    end
  end
end
