include Warden::Test::Helpers
require "rake"

module CapybaraHelper
  PAGE_MAP = {
    # General
    "Home": "/",
    "Admin": "/admin",
    "Sign In": "/sign_in",
    "Admin Home": "/admin",
    # Upload resource
    "Database": "/admin/uploads",
    "New Upload": "/admin/uploads/new",
    # Tag resource
    "Tag List": "/admin/topics",
    "New Tag": "/admin/topics/new",
    # Category resource
    "Category Bank": "/admin/categories",
    "New Category": "/admin/categories/new",
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
    "Cancel": "cancel-button",
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
    # Category resource
    "Category Bank": "category-list-button",
    "New Category": "new-category-button",
    "Back to Category Bank": "back-to-category-list-button",
  }

  FORM_BUTTON_MAP = {
    "Save": "save-button",
    "Add new Tag": "add-new-tag-button",
    "Add Category": "add-category-button",
  }

  def capybara_upload_zip(zip_name)
    if zip_name != ""
      capybara_login("admin123@admin.com", "admin123")
      visit '/admin/uploads/new'
      attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
      find("#upload-button").click
    end
  end

  def capybara_set_categories(category_bank)
    Category.destroy_all
    category_bank.each do |category_name|
      Category.create(name: category_name)
    end
  end

  def capybara_delete_categories(category_bank)
    category_bank.each do |category_name|
      Category.find_by(name: category_name).destroy
    end
  end

  def capybara_remove_all_categories
    Category.destroy_all
  end

  def capybara_add_categories(category_bank)
    category_bank.each do |category_name|
      category = Category.find_by(name: category_name)
      if category.nil?
        Category.create(name: category_name )
      end
    end
  end

  def capybara_login(email, password)
    User.destroy_all
    user = User.create(email: email, password: password, password_confirmation: password)
    login_as(user, :scope => :user)
  end

  def capybara_logout
    logout
  end

  def setup_db
    Rails.application.load_tasks
    Rake::Task['db:reset'].invoke
  end
end
World(CapybaraHelper)