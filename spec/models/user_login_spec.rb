require 'spec_helper'
require 'rails_helper'

# These tests were more important when login was implemented from scratch
# Now that the login is handled by devise, these tests mostly show that
# we've implemented devise somewhat properly, and know what to expect from it

describe User do

    before(:each) do
        @user  = "Username of some sort"
        @email = "generic@berkeley.edu"
        @pass  = "Password of some sort"
        @building = "Location of some sort"
    end

    it "accepts a username, email, password, and building" do
        expect(User).to receive(:new).and_return(User.new(username: @user, password: @pass, email: @email))
        User.init(@user, @email, @pass, @building)
    end

    it "hides the password" do
        User.init(@user, @email, @pass, @building)
        expect(User.find_by(username: @user).encrypted_password).not_to eq(@pass)
    end

    it "properly saves" do
        v = User.init(@user, @email, @pass, @building)
        expect(v).to eq(true)
    end

    it "defaults to User privileges" do
        User.init(@user, @email, @pass, @building)
        expect(User.find_by(username: @user).manage?).to eq(false)
    end

    it "promotes to Manager privileges" do
        User.init(@user, @email, @pass, @building)
        u = User.find_by(username: @user)
        u.promote("Manager")
        expect(u.manage?).to eq(true)
    end

    it "promotes to Admin privileges" do
        User.init(@user, @email, @pass, @building)
        u = User.find_by(username: @user)
        u.promote("Admin")
        expect(u.admin?).to eq(true)
    end

    it "gives Admins the Manager privileges" do
        User.init(@user, @email, @pass, @building)
        u = User.find_by(username: @user)
        u.promote("Admin")
        expect(u.manage?).to eq(true)
    end

    it "does not give Managers the Admin privileges" do
        User.init(@user, @email, @pass, @building)
        u = User.find_by(username: @user)
        u.promote("Manager")
        expect(u.admin?).to eq(false)
    end

end
