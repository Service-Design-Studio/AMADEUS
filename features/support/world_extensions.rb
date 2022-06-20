module KnowsUser
  def login
    visit '/sign_in'
    fill_in :email, with: 'admin'
    fill_in :password, with: 'admin'
    find("#sign-in-button").click
  end
end
World(KnowsUser)