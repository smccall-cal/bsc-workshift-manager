require 'rails_helper'
require 'uri'

RSpec.describe PreferencesController, type: :controller do
    
    before :each do |example|
        unless example.metadata[:skip_before]
            # @request.env["devise.mapping"] = Devise.mappings[:user]
            @user = User.new :id => 1, :init => false
            allow(controller).to receive(:authenticate_user!).and_return(true)
            allow(controller).to receive(:current_user).and_return(@user)
            allow(controller).to receive(:user_signed_in?).and_return(true)
            @preference = Preference.new :id => 1
            @params = {:user_id => @user}
        end
    end

    describe "GET #index" do

        it "redirects to no preference page if the user has no preference" do
            allow(@user).to receive(:preference).and_return(nil)
            get :index, :params => @params
            expect(response).to redirect_to(no_user_preferences_path(@user))
        end
        
        it "redirects to my preference page if the user has a preference" do
            allow(@user).to receive(:preference).and_return(@preference)
            get :index, :params => @params
            expect(response).to redirect_to(user_preference_path(@user, @preference))
        end

    end
    
    describe "GET #show" do

        it "redirects to no preference page if the user has no preference" do
            allow(@user).to receive(:preference).and_return(nil)
            get :show, :params => @params.merge({:id => @preference})
            expect(response).to redirect_to(no_user_preferences_path(@user))
        end

    end
    
    describe "GET #new" do
        
        it "clears sessions for sort/filter if the request format is html" do
            expect(controller).to receive(:clear_sessions).with "rank"
            get :new, :format => :html, :params => @params
        end
        
        it "doesn't clear sessions for sort/filter if the request format is js" do
            expect(controller).not_to receive :clear_sessions
            get :new, :format => :js, :xhr => true, :params => @params
        end
        
        it "gets params for sort/filter" do
            expect(controller).to receive :sort_filter_params
            get :new, :params => @params
        end
        
        it "assigns filtered shifts to @shifts" do
            get :new, :params => @params.merge({:key=>"location", :query=>"i"})
            expect(assigns(:shifts)).to eq (Preference.shifts.select {|sh| ShiftDetail.valueOf(sh, @params[:key]) =~ Regexp.new(Regexp.escape(URI.decode(@params[:query])), "i")})
        end
        
        it "assigns the rank parameter to @rank" do
            get :new, :params => @params.merge({:rank => "1"})
            expect(assigns(:rank)).to eq "1"
        end
    end
    
    describe "POST #create" do
        
        it "calls preference_params" do
            expect(controller).to receive :preference_params
            post :create, :params => @params
        end
        
        it "calls build_preference on current user with preference parameters" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            expect(@user).to receive(:build_preference).with({:params => "some params"})
            allow(@user).to receive(:build_preference).and_return(@preference)
            post :create, :params => @params
        end
        
        it "redirects to my preference page with success message if the create's valid" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            allow(@user).to receive(:build_preference).and_return(@preference)
            allow(@preference).to receive(:save).and_return(true)
            post :create, :params => @params
            expect(response).to redirect_to user_preference_path(@user, @preference)
            expect(flash[:notice]).to eq "Preference was successfully created."
        end
        
        it "redirects to my preference page with fail message if the create's invalid" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            allow(@user).to receive(:build_preference).and_return(@preference)
            allow(@preference).to receive(:save).and_return(false)
            post :create, :params => @params
            expect(response).to redirect_to new_user_preference_path(@user)
            expect(flash[:alert]).to eq @preference.errors.full_messages[0]
        end
        
    end
    
    describe "POST #update" do
        
        before :each do
            @params = {:user_id => @user, :id => @preference}
            allow(@user).to receive(:preference).and_return(@preference)
        end
        
        it "calls preference_params" do
            expect(controller).to receive :preference_params
            allow(@preference).to receive(:update).and_return(false)
            post :update, :params => @params
        end
        
        it "calls update on current user's preference with preference parameters" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            expect(@preference).to receive(:update).with({:params => "some params"})
            # allow(@user).to receive(:build_preference).and_return(@preference)
            post :update, :params => @params
        end
        
        it "redirects to my preference page with success message if the update's valid" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            allow(@preference).to receive(:update).and_return(true)
            post :update, :params => @params
            expect(response).to redirect_to user_preference_path(@user, @preference)
            expect(flash[:notice]).to eq "Preference was successfully updated."
        end
        
        it "redirects to edit preference page with fail message if the update's invalid" do
            allow(controller).to receive(:preference_params).and_return({:params => "some params"})
            allow(@preference).to receive(:update).and_return(false)
            post :update, :params => @params
            expect(response).to redirect_to edit_user_preference_path(@user, @preference)
            expect(flash[:alert]).to eq @preference.errors.full_messages[0]
        end
        
    end
    
    describe "set_preference" do
        
        it "sets @preference the preference of @user" do
            controller.instance_variable_set(:@user, @user)
            allow(@user).to receive(:preference).and_return(@preference)
            controller.set_preference
            expect(assigns(:preference)).to eq @preference
        end
        
    end
    
    describe "set_user" do
        
        it "sets @user the current user if a user is logged in" do
            allow(controller).to receive(:current_user).and_return(@user)
            allow(controller).to receive(:user_signed_in?).and_return(true)
            controller.set_user
            expect(assigns(:user)).to eq @user
        end
        
    end
    
    describe "preference_params" do
        
        it "returns trusted preference parameters" do
            @params = {:shift => "shift", :schedule => "schedule"}
            allow(controller).to receive(:params).and_return({:preference => @params.merge({:evil => "evil"})})
            expect(controller.preference_params).to eq @params
        end
        
    end

end