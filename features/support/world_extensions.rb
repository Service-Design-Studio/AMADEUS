include Warden::Test::Helpers
require "rake"

module CapybaraHelper
  PAGE_MAP = {
    # General
    "Home": "/",
    "Admin": "/admin",
    "Sign In": "/sign_in",
    # Upload resource
    "Database": "/admin/uploads",
    "New Upload": "/admin/uploads/new",
    # Tag resource
    "Tag List": "/admin/topics",
    "New Tag": "/admin/topics/new",
  }

  BUTTON_MAP = {
    # General
    "AMADEUS": "amadeus-button",
    "Home": "home-button",
    "Admin": "admin-button",
    "Sign In": "sign-in-button",
    "Sign Out": "sign-out-button",
    "Actions": "actions-button",
    "Back to Home": "back-to-home-button",
    "Delete": "delete-button",
    "Return": "return-button",
    # Upload resource
    "Database": "database-button",
    "Back to Database": "back-to-database-button",
    "Upload": "upload-button",
    "New Upload": "new-upload-button",
    "Delete this Upload": "delete-this-upload-button",
    # Tag resource
    "Tag List": "tag-list-button",
    "New Tag": "new-tag-button",
    "Back to Tag List": "back-to-tag-list-button",
  }

  FORM_BUTTON_MAP = {
    "Save": "save-button",
    "Add new Tag": "add-new-tag-button"
  }


  def capybara_upload_zip(zip_name)
    setup_db
    if zip_name != ""
      visit '/admin/uploads/new'
      attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
      find("#upload-button").click
    end
  end

  def setup_db
    Rails.application.load_tasks
    Rake::Task['db:reset'].invoke
  end

  def capybara_login(email, password)
    setup_db
    password
    user = User.find_by(email: email)
    login_as(user, :scope => :user)
  end

  def capybara_logout
    logout
  end
end
World(CapybaraHelper)