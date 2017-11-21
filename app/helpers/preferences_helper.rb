module PreferencesHelper
  def find_user_id(user_name)
    return User.find_by(username: user_name).id
  end
end
