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
end
