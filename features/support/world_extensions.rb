include Warden::Test::Helpers

module KnowsUser
  def capybara_login(email, password)
    user = User.create!(email: email, password: password)
    login_as(user, :scope => :user)
  end

  def capybara_logout
    logout()
  end
end
World(KnowsUser)