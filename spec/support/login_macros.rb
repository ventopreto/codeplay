module LoginMacros
  def user_login( user = User.create!(email: 'x@gmail.com', password: '123456'))
    login_as user, scope: :user
  end
end