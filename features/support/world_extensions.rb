include Warden::Test::Helpers

module KnowsUser
  def login(email, password)
    user = User.create!(email: email, password: password)
    login_as(user, :scope => :user)
  end
end
World(KnowsUser)