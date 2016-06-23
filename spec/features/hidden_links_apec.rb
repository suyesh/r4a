require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:project) {FactoryGirl.create(:project)}

  context "anonymous users" do
    scenario "Cannot see the New Project Link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "Cannot see the Delete Project" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "Regular Users" do
    before do
      login_as(user)
    end
    scenario "Cannot see the New Project Link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "Cannot see the Delete Project" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "Admin users" do
    before do
      login_as(admin)
    end
    scenario "Can see the New Project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "Can see the Delete Project" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
  end
end
