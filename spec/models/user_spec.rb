require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#admin" do
    it "is false by default" do
      user = User.create(email: 'email@example.com', password: 'asdfasdf')
      expect(user.admin).to eq false
      expect(user.admin?).to eq false
    end
  end
end
