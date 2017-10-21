Given "I set my preferences before" do
  @preference = Preference.new
  @preference.create
end

Given "And I didn't set my preferences before"  do
  redirect_to  no_user_preferences_path(@user)
end
