require 'rails_helper'

RSpec.describe "preferences/new", type: :view do
  before(:each) do
    @user  = "Username of some sort"
    @email = "generic@berkeley.edu"
    @pass  = "Password of some sort"
    @building = "Location of some sort"
    User.init(@user, @email, @pass, @building)
    # @user_id = User.find_by(username: @user).id
    assign(:preference, Preference.new())
  end

  # it "renders new preference form" do
  #   render
  #
  #   assert_select "form[action=?][method=?]", new_user_preference_path(@user), "post",:id => "preference", :user_id => "#{find_user_id(@user)}" do
  #
  #   end
  # end
end
