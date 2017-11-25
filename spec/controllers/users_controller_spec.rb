require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "GET #entry" do

        it "redirects to sign in page if no user's logged in" do
            allow(controller).to receive(:user_signed_in?).and_return(false)
            get :entry
            expect(response).to redirect_to(new_user_session_path)
        end
        
        it "redirects to personal page if a user's logged in" do
            @user = User.new(:id=>1, :init=>false)
            allow(controller).to receive(:authenticate_user!).and_return(true)
            allow(controller).to receive(:current_user).and_return(@user)
            allow(controller).to receive(:user_signed_in?).and_return(true)
            get :entry
            expect(response).to redirect_to(user_path(1))
        end

    end
    
    describe "GET #show" do
        
        before(:each) do
            @user = User.new(:id=>1, :role=>"Manager", :init=>false)
            allow(controller).to receive(:authenticate_user!).and_return(true)
            allow(controller).to receive(:current_user).and_return(@user)
            allow(controller).to receive(:user_signed_in?).and_return(true)
        end
        
        it "checks whether current user is a manager" do
            expect(@user).to receive :manage?
            get :show, :params => {:id => 1}
        end
        
        it "assigns @manager whether current user is a manager" do
            get :show, :params => {:id => 1}
            expect(assigns(:manager)).to eq @user.manage?
        end
        
    end
    
    describe "GET #index" do
        
        before(:each) do
            @user = User.new(:id=>1, :role=>"Manager", :init=>false)
            allow(controller).to receive(:authenticate_user!).and_return(true)
            allow(controller).to receive(:current_user).and_return(@user)
            allow(controller).to receive(:user_signed_in?).and_return(true)
        end
        
        it "clears sessions for sort/filter if the request format is html" do
            expect(controller).to receive :clear_sessions
            get :index, :format => :html
        end
        
        it "doesn't clear sessions for sort/filter if the request format is js" do
            expect(controller).not_to receive :clear_sessions
            get :index, :format => :js, :xhr => true
        end
        
        it "gets params for sort/filter" do
            expect(controller).to receive :index_params
            get :index
        end
        
        it "assigns sorted and filtered users to @users" do
            @params = {:key=>"username", :query=>"i", :sort=>"username"}
            get :index, :params => @params
            expect(assigns(:users)).to eq User.select {|user| user[@params[:key]] =~ @params[:query] and user.role == "User" }.sort_by{|u| u[@params[:sort]]}
        end
        
    end
    
    describe "clear_sessions" do
        
        it "clears sessions for sort/filter" do
            session["key"] = "some value"
            session["query"] = "some value"
            session["sort"] = "some value"
            controller.clear_sessions
            expect(session["key"]).to be_nil
            expect(session["query"]).to be_nil
            expect(session["sort"]).to be_nil
        end
        
    end
    
    describe "index_params" do
        
        it "calls methods to get params" do
            expect(controller).to receive :get_key
            expect(controller).to receive :get_query
            expect(controller).to receive :get_sort
            controller.index_params
        end
        
    end
    
    describe "get_key" do
        
        it "sets @key to params[:key] if it exists" do
            controller.params[:key] = "some value"
            controller.get_key
            expect(assigns(:key)).to eq "some value"
        end
        
        it "sets @key to session[:key] if it exists and no params[:key]" do
            controller.params[:key] = nil
            session[:key] = "some value"
            controller.get_key
            expect(assigns(:key)).to eq "some value"
        end
        
        it "sets @key to default value if no params[:key] and session[:key]" do
            controller.params[:key] = nil
            session[:key] = nil
            controller.get_key
            expect(assigns(:key)).to eq "username"
        end
        
        it "updates sessions" do
            controller.params[:key] = "some value"
            controller.get_key
            expect(session[:key]).to eq "some value"
        end
        
    end
    
    describe "get_query" do
        
        it "sets @query_ to params[:query] if it exists" do
            controller.params[:query] = "some value"
            controller.get_query
            expect(assigns(:query_)).to eq "some value"
        end
        
        it "sets @query_ to session[:query] if it exists and no params[:query]" do
            controller.params[:query] = nil
            session[:query] = "some value"
            controller.get_query
            expect(assigns(:query_)).to eq "some value"
        end
        
        it "sets @query_ to default value if no params[:query] and session[:query]" do
            controller.params[:query] = nil
            session[:query] = nil
            controller.get_query
            expect(assigns(:query_)).to eq ""
        end
        
        it "sets @query to be regexp version of @query_ which is case-insensitive" do
            controller.params[:query] = "some value"
            controller.get_query
            expect(assigns(:query)).to eq Regexp.new "some value", "i"
        end
        
        it "updates sessions" do
            controller.params[:query] = "some value"
            controller.get_query
            expect(session[:query]).to eq "some value"
        end
        
    end
    
    describe "get_sort" do
        
        it "sets @sort to params[:sort] if it exists" do
            controller.params[:sort] = "some value"
            controller.get_sort
            expect(assigns(:sort)).to eq "some value"
        end
        
        it "sets @sort to session[:sort] if it exists and no params[:sort]" do
            controller.params[:sort] = nil
            session[:sort] = "some value"
            controller.get_sort
            expect(assigns(:sort)).to eq "some value"
        end
        
        it "sets @sort to default value if no params[:sort] and session[:sort]" do
            controller.params[:sort] = nil
            session[:sort] = nil
            controller.get_sort
            expect(assigns(:sort)).to eq ""
        end
        
        it "updates sessions if params[:sort] doesn't equal to session[:sort]" do
            controller.params[:sort] = "some value"
            session[:sort] = "other value"
            controller.get_sort
            expect(session[:sort]).to eq "some value"
        end
        
        it "resets sessions if params[:sort] equals to session[:sort]" do
            controller.params[:sort] = "some value"
            session[:sort] = "some value"
            controller.get_sort
            expect(session[:sort]).to eq ""
        end
        
    end

end