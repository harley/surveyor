require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#admin" do
    it "is false by default" do
      user = User.create(email: 'email@example.com', password: 'asdfasdf')
      expect(user.admin).to eq false
      expect(user.admin?).to eq false
    end
  end

  describe "VISITOR" do
    it { expect(User::VISITOR.admin?).not_to be_truthy }
    it { expect(User::VISITOR.role).to eql "visitor" }
  end
end
