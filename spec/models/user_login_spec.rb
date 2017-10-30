require 'spec_helper'
require 'User'

# These tests were more important when login was implemented from scratch
# Now that the login is handled by devise, these tests mostly show that
# we've implemented devise somewhat properly, and know what to expect from it

describe User do

    before(:each) do
        @user  = "Username of some sort"
        @email = "generic@berkeley.edu"
        @pass  = "Password of some sort"
    end

    it "accepts a username, email, and password" do
        expect(User).to receive(:new).and_return(User.new(username: @user, password: @pass, email: @email))
        User.init(@user, @email, @pass)
    end

    it "correctly hides the password" do
        User.init(@user, @email, @pass)
        expect(User.find_by(username: @user).encrypted_password).not_to eq(@pass)
    end

    it "properly saves" do
        v = User.init(@user, @email, @pass)
        expect(v).to eq(true)
    end

end
