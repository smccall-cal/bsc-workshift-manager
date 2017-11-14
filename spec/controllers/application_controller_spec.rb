require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    
    controller do
        def index
            render :plain => "Hello world"
        end
    end
    
    before(:each) do
        @user = User.new
    end
    
    describe "before_action :new_password" do
        it "isn't called when the route is for logging out" do
            allow(controller).to receive(:log_out).and_return(true)
            get :index
            expect(response.body).to eq "Hello world"
        end
        
        it "doesn't check first-time-user if no user's logged in" do
            allow(controller).to receive(:current_user).and_return(nil)
            get :index
            expect(response.body).to eq "Hello world"
        end
        
        it "redirect user to set new password if it's first time loggin" do
            allow(controller).to receive(:current_user).and_return(@user)
            allow(@user).to receive(:init).and_return(true)
            get :index
            expect(response).to redirect_to edit_user_registration_path
        end
        
        it "doesn't redirect user to set new password if it's not first time loggin" do
            allow(controller).to receive(:current_user).and_return(@user)
            allow(@user).to receive(:init).and_return(false)
            get :index
            expect(response.body).to eq "Hello world"
        end
    end
    
    describe "log_out" do
        it "checks if the route is sessions#destroy" do
            allow(controller).to receive(:controller_name).and_return("sessions")
            allow(controller).to receive(:action_name).and_return("destroy")
            expect(controller.log_out).to be_truthy
        end
    end
end
