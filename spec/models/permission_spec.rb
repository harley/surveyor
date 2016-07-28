require 'rails_helper'

RSpec::Matchers.define :allow? do |controller, action|
  match do |actual|
    actual.allow?(controller, action)
  end
end

RSpec.describe Permission, type: :model do
  let(:user) {User.create email: 'a@example.com', password: 'asdfasdf', admin: false}
  let(:admin) {User.create email: 'admin@example.com', password: 'asdfasdf', admin: true}

  context "admin" do
    let(:permission) { Permission.new(admin) }

    it "has acccess to all" do
      expect(permission).to allow?("surveys", "new")
    end
  end
end
