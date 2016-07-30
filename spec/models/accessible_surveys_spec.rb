require 'rspec'
require 'rails_helper'

describe AccessibleSurveys do
  let!(:survey_1) { Survey.create(title: "survey 1") }
  let!(:survey_2) { Survey.create(title: "survey 2") }
  let!(:survey_3) { Survey.create(title: "survey 3") }

  context "user" do
    let!(:user) { User.create(email: "user@example.com", password: "password") }
    let(:subject) { AccessibleSurveys.new(user).surveys }

    before do
      Collaboration.owner(survey: survey_1, user: user)
      Collaboration.owner(survey: survey_2, user: user)
    end

    it "shows only user' surveys" do
      expect(subject).to include(survey_1, survey_2)
    end
  end

  context "admin" do
    let!(:admin) { User.create(email: "admin@example.com", password: "password", admin: true) }
    let(:subject) { AccessibleSurveys.new(admin).surveys }

    it "shows all surveys" do
      expect(subject).to include(survey_1, survey_2, survey_3)
    end
  end

end