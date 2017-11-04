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
    
end
