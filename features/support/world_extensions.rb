include Warden::Test::Helpers

module KnowsUser
  def capybara_login(email, password)
    user = User.create!(email: email, password: password)
    login_as(user, :scope => :user)
  end

  def capybara_logout
    logout()
  end

  def capybara_upload_zip(zip_name)
    visit '/admin/uploads/new'
    attach_file(Rails.root + "app/assets/test_zip/#{zip_name}")
    find("#create-upload-button").click
  end
end
World(KnowsUser)