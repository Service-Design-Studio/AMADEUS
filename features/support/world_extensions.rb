include Warden::Test::Helpers
require "rake"
require 'zip'

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
    "Tag List": "/admin/tags",
    "New Tag": "/admin/tags/new",
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
    "Upload": "upload-button",
    "Save": "save-button",
    "Add new Tag": "add-new-tag-button",
    "Add Category": "add-category-button",
  }

  ARTICLES_ARRAY = [
    "Russia's economy in for a bumpy ride as sanctions bite - BBC News",
    "Russia sentences US teacher to 14 years for cannabis smuggling - BBC News",
    "Chinese drone firm DJI pauses operations in Russia and Ukraine - BBC News",
    "Combat drones_ We are in a new era of warfare - here's why - BBC News",
    "How many Ukrainian refugees are there and where have they gone_ - BBC News",
    "Ukraine war_ Thousands of civilians trapped in Severodonetsk - BBC News",
  ]

  TAG_ARRAY = %w[ cut economy noise russia sanction basketball drug fogel russia star dji drone product russia use
attack drone technology use warfare kyiv refugee russia ukraine ukrainians azot control plant russia severodonetsk ]

  def capybara_get_article_idx(article_name)
    CapybaraHelper::ARTICLES_ARRAY.index(article_name) + 1
  end

  def capybara_get_tag_idx(tag_name)
    CapybaraHelper::TAG_ARRAY.index(tag_name) + 1
  end

  def capybara_upload_zip(zip_name)
    if zip_name != ""
      # capybara_login("admin123@admin.com", "admin123")
      # visit '/admin/uploads/new'
      # attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
      # find("#upload-button").click
      Zip::File.open(Rails.root + "app/assets/test_zip/#{zip_name}") do |zip_file|
        zip_file.each do |entry|
          if entry.file? && entry.name.end_with?(".pdf")
            new_upload = Upload.new
            content = ExtractPdf.get_pdf_text(entry)
            new_upload.file.attach(io: StringIO.new(entry.get_input_stream.read), filename: entry.name)
            summariser_response = Summariser.request(content)
            summary = summariser_response[:summary]
            new_upload.content = content
            new_upload.summary = summary
            new_upload.ml_status = "Complete"
            new_upload.save
          end
        end
      end
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
        Category.create(name: category_name)
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