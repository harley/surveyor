require 'rails_helper'

module AuthHelper
  def log_in(email, password)
    visit new_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log In"
    expect(page).to have_content "Logged in!"
  end
end

RSpec.describe "Surveys", type: :feature do
  include AuthHelper
  describe "GET /surveys/new" do
    it "denies access for guests" do
      visit '/surveys/new'
      # save_and_open_page
      expect(page).to have_content("Access Denied.")
      expect(page.status_code).to eq 403
    end

    it "allows users" do
      user = User.create(email: 'harley@example.com', password: 'asdfasdf', admin: true)
      log_in(user.email, user.password)
      visit '/surveys/new'
      expect(page).to have_content "New Survey"
    end
  end

  describe "GET /surveys/:id/edit" do
    let(:non_admin) { User.create(email: 'harley@example.com', password: 'asdfasdf', admin: false) }
    let(:admin) { User.create(email: 'admin@example.com', password: 'asdfasdf', admin: true) }

    before do
      @survey = Survey.create title: "hello"
    end

    it "denies access for non admin" do
      log_in(non_admin.email, non_admin.password)
      visit edit_survey_path(@survey)
      expect(page).to have_content("Insufficient Permission.")
    end

    it "allows admin" do
      log_in(admin.email, admin.password)
      visit edit_survey_path(@survey)
      expect(page).to have_content("Questions")
    end
  end
end
