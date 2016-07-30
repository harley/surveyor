require 'rails_helper'

RSpec::Matchers.define :allow? do |controller, action|
  match do |actual|
    actual.allow?(controller, action)
  end
end

RSpec.describe Permission, type: :model do
  context "user" do
    let(:user) { User.create email: 'a@example.com', password: 'asdfasdf', admin: false }
    let(:permission) { Permission.new(user) }

    it "can show/edit survey" do
      %w(create edit update show).each do |action|
        expect(permission).to allow?("surveys", action)
      end
    end
  end

  context "admin" do
    let(:admin) { User.create email: 'admin@example.com', password: 'asdfasdf', admin: true }
    let(:permission) { Permission.new(admin) }

    it "has acccess to all" do
      %w(create edit update show destroy).each do |action|
        expect(permission).to allow?("surveys", action)
      end
    end
  end

  context "visitor" do
    let(:user) { NullUser.new }
    let(:permission) { Permission.new(user) }

    it "cannot access to other edit survey functions" do
      %w(create edit update destroy).each do |action|
        expect(permission).to_not allow?("surveys", action)
      end
    end

    it "can access to view survey only" do
      %w(show).each do |action|
        expect(permission).to allow?("surveys", action)
      end
    end
  end
end
