include Warden::Test::Helpers
require "rake"

module CapybaraHelper
  def capybara_login(email, password)
    setup_db
    user = User.find_by(email: email)
    login_as(user, :scope => :user)
  end

  def capybara_logout
    logout
  end

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
end
World(CapybaraHelper)