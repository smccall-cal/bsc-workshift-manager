require "rails_helper"

RSpec.describe PreferencesController, type: :routing do
    describe "routing" do
      before :each do
        user = User.create(:username=>"cancer")
    end

    it "routes to #new" do
      expect(:get => "/users/1/preferences/new").to route_to("preferences#new",:user_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/users/1/preferences/1").to route_to("preferences#show", :id => "1",:user_id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/users/1/preferences/1/edit").to route_to("preferences#edit", :id => "1",:user_id => "1")
    end

    it "routes to #create" do
      expect(:post => "/users/1/preferences").to route_to("preferences#create",:user_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/1/preferences/1").to route_to("preferences#update", :id => "1",:user_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/1/preferences/1").to route_to("preferences#update", :id => "1",:user_id => "1")
    end

  end
end
