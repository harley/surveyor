require "rails_helper"

RSpec::Matchers.define :allow? do |survey|
  match do |actual|
    actual.allow?(survey)
  end
end

describe SurveyEditPermission do
  describe ".allow?" do
    context "admin" do
      it "allows to edit survey" do
        survey = Survey.create(title: "survey 1")
        admin = User.create(email: "admin@example.com", password: "password", admin: true)
        permission = SurveyEditPermission.new(admin)
        expect(permission).to allow?(survey)
      end
    end
    context "owner" do
      it "allows to edit survey" do
        survey = Survey.create(title: "survey 1")
        user = User.create(email: "admin@example.com", password: "password", admin: false)
        Collaboration.owner(survey: survey, user: user)

        permission = SurveyEditPermission.new(user)
        expect(permission).to allow?(survey)
      end
    end
    context "editor" do
      it "allows to edit survey" do
        survey = Survey.create(title: "survey 1")
        user = User.create(email: "admin@example.com", password: "password", admin: false)
        Collaboration.editor(survey: survey, user: user)

        permission = SurveyEditPermission.new(user)
        expect(permission).to allow?(survey)
      end
    end
    context "otherwise" do
      it "allows to edit survey" do
        survey = Survey.create(title: "survey 1")
        user = User.create(email: "admin@example.com", password: "password", admin: false)

        permission = SurveyEditPermission.new(user)
        expect(permission).not_to allow?(survey)
      end
    end
  end
end