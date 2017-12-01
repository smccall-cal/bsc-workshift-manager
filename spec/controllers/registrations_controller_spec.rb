require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

    let(:valid_params) do
        {"email"=>"fad11204@berkeley.edu", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]", "current_password"=>"[FILTERED]"}
    end

    describe "PUT #update" do

        before(:each) do
            @user = User.new(:id=>1)
            allow(controller).to receive(:authenticate_scope!).and_return(@user)
            allow(controller).to receive(:current_user).and_return(@user)
            allow(User).to receive(:find).and_return(@user)
            allow(controller).to receive(:resource_name).and_return("user")
            allow(controller).to receive(:update_resource).and_return(true)
            @request.env["devise.mapping"] = Devise.mappings[:user]
        end

        it "sets current user's init to false" do
            put :update, :params => valid_params
            expect(@user.init).to be_falsy
        end
        it "redirects user to make preference" do
            put :update, :params => valid_params
            expect(response.location).to eq new_user_preference_path(@user.id)
        end
        it "doesn't redirect user if current user is first-time-user" do
            put :update, :params => valid_params
            expect(response).not_to redirect_to edit_user_registration_path
        end

    end

    describe "POST #masscreate" do

        before :each do
            @names = "A\nB\nC\nD\n"
            @emails = @names.split("\n").map{|n| n + "@berkeley.edu"}.join("\n")
            @user = User.new(:id=>1, :role => "Manager", :building => "CZ", :init => false)

            allow(controller).to receive(:current_user).and_return(@user)
            @request.env["devise.mapping"] = Devise.mappings[:user]
        end

        it "adds all the users" do
            post :mass_create, :params => {user: {username: @names, email: @emails, building: "CZ", redirect: mass_add_path}}
            expect(User.find_by(username: "A")).to be_truthy
            expect(User.find_by(username: "B")).to be_truthy
            expect(User.find_by(username: "C")).to be_truthy
            expect(User.find_by(username: "D")).to be_truthy
        end
        
    end
    
    describe "GET #delete" do
        
        before(:each) do
            @user = User.new(:id=>1, :role => "Manager", :building => "CZ", :init => false)

            allow(controller).to receive(:current_user).and_return(@user)
            @request.env["devise.mapping"] = Devise.mappings[:user]
        end
        
        it "assigns @users with all the users" do
            get :delete
            expect(assigns(:users)).to eq User.all.select {|user| user.role == "User"}
        end
        
    end
    
    describe "DELETE #revoke" do
        
        before(:each) do
            User.init("Foo","Foo@berkeley.edu","Bar123456","CZ")
            @someuser = User.find_by_username("Foo")
            @user = User.new(:id=>1, :role => "Manager", :building => "CZ", :init => false)

            allow(controller).to receive(:current_user).and_return(@user)
            @request.env["devise.mapping"] = Devise.mappings[:user]
        end
        
        it "deletes user with given id in the params" do
            delete :revoke, :params => {:id => @someuser.id}
            expect(User.where(:username => "Foo")).not_to exist
        end
        
    end

end
