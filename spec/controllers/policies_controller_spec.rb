require "rails_helper"

RSpec.describe PoliciesController, type: :controller do
    
    before :each do
        # @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = User.new :id => 1, :init => false, :role => "Manager"
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        allow(controller).to receive(:user_signed_in?).and_return(true)
        @policy = Policy.new :id => 1, :filename => "policy_file"
    end

    describe "GET #index" do

        it "redirects to new policy page if there's no policies" do
            policies = double("ActiveRecord::Relation", :empty? => true)
            allow(Policy).to receive(:all).and_return(policies)
            get :index
            expect(response).to redirect_to(new_policy_path)
        end
        
        it "redirects to policy page if there's some policy" do
            policies = double("ActiveRecord::Relation", :empty? => false)
            allow(Policy).to receive(:all).and_return(policies)
            allow(Policy).to receive(:first).and_return(@policy)
            get :index
            expect(response).to redirect_to(policy_path(@policy))
        end

    end
    
    describe "GET #new" do
        
        it "redirects to policy page if there's already some policy" do
            policies = double("ActiveRecord::Relation", :empty? => false)
            allow(Policy).to receive(:all).and_return(policies)
            allow(Policy).to receive(:first).and_return(@policy)
            get :new
            expect(response).to redirect_to(policy_path(@policy))
        end
        
        it "assigns @policy a new policy object" do
            policies = double("ActiveRecord::Relation", :empty? => true)
            allow(Policy).to receive(:all).and_return(policies)
            allow(Policy).to receive(:new).and_return(@policy)
            get :new
            expect(assigns(:policy)).to eq @policy
        end
        
    end
    
    describe "POST #create" do
        
        it "calls upload_file" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            expect(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(Policy).to receive(:new).and_return(@policy)
            get :create
        end
        
        it "creates a policy with filename from @policy_io" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(controller).to receive(:upload_file)
            expect(Policy).to receive(:new).with(:filename => policy_io.original_filename)
            allow(Policy).to receive(:new).and_return(@policy)
            get :create
        end
        
        it "redirects to policy page with success message if the create's valid" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(controller).to receive(:upload_file)
            allow(Policy).to receive(:new).and_return(@policy)
            allow(@policy).to receive(:save).and_return(true)
            get :create
            expect(response).to redirect_to policies_path
            expect(flash[:notice]).to eq "Policy was successfully created."
        end
        
        it "renders new policy page if the create's invalid" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(controller).to receive(:upload_file)
            allow(Policy).to receive(:new).and_return(@policy)
            allow(@policy).to receive(:save).and_return(false)
            get :create
            expect(response).to render_template :new
        end
        
    end
    
    describe "PUT #update" do
        
        it "calls delete_file" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            allow(Policy).to receive(:find).and_return(@policy)
            expect(controller).to receive(:delete_file)
            allow(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(@policy).to receive(:update).and_return(false)
            get :update, :params => {:id => 1}
        end
        
        it "calls upload_file" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            expect(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(Policy).to receive(:new).and_return(@policy)
            allow(@policy).to receive(:update).and_return(false)
            get :update, :params => {:id => 1}
        end
        
        it "calls update on the policy with filename from @policy_io" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            allow(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(Policy).to receive(:new).and_return(@policy)
            expect(@policy).to receive(:update).with(:filename => policy_io.original_filename)
            get :update, :params => {:id => 1}
        end
        
        it "redirects to policy page with success message if the update's valid" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            allow(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(Policy).to receive(:new).and_return(@policy)
            allow(@policy).to receive(:update).and_return(true)
            get :update, :params => {:id => 1}
            expect(response).to redirect_to policies_path
            expect(flash[:notice]).to eq "Policy was successfully updated."
        end
        
        it "renders edit policy page if the update's invalid" do
            policy_io = double("Tempfile", :original_filename => "tempfilename")
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            allow(controller).to receive(:upload_file)
            controller.instance_variable_set(:@policy_io, policy_io)
            allow(Policy).to receive(:new).and_return(@policy)
            allow(@policy).to receive(:update).and_return(false)
            get :update, :params => {:id => 1}
            expect(response).to render_template :edit
        end
        
    end
    
    describe "DELETE #destroy" do
        
        it "calls delete_file" do
            allow(Policy).to receive(:find).and_return(@policy)
            expect(controller).to receive(:delete_file)
            delete :destroy, :params => {:id => 1}
        end
        
        it "calls destroy on @policy" do
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            expect(@policy).to receive(:destroy)
            delete :destroy, :params => {:id => 1}
        end
        
        it "redirects to the policy page" do
            allow(Policy).to receive(:find).and_return(@policy)
            allow(controller).to receive(:delete_file)
            delete :destroy, :params => {:id => 1}
            expect(response).to redirect_to policies_path
        end
        
    end
    
    describe "GET #download" do
        
        it "sends the policy file to the user" do
            allow(Policy).to receive(:find).and_return(@policy)
            expect(controller).to receive(:send_file).with(
                Rails.root.join('public', 'uploads', @policy.filename),
                filename: @policy.filename,
                type: "text/plain",
                disposition: 'attachment'
            )
            get :download, :params => {:id => 1}
        end
        
    end
    
    describe "set_policy" do
        
        it "sets @policy with id in the params" do
            allow(Policy).to receive(:find).and_return(@policy)
            controller.set_policy
            expect(assigns(:policy)).to eq @policy
        end
        
    end
    
    describe "policy_params" do
        
        it "fetches the policy_io info from params" do
            allow(controller).to receive(:params).and_return({:policy => {:policy_file => "tempfile"}})
            expect(controller.policy_params).to eq "tempfile"
        end
        
    end
    
    describe "upload_file" do
        
        it "calls policy_params" do
            policy_io = double("Tempfile", :original_filename => "tempfilename", :path => "")
            expect(controller).to receive(:policy_params)
            allow(controller).to receive(:policy_params).and_return(policy_io)
            allow(File).to receive(:open)
            controller.upload_file
        end
        
        it "writes the content in Tempfile to local file system" do
            policy_io = double("Tempfile", :original_filename => "tempfilename", :path => "", :read => "text")
            expect(controller).to receive(:policy_params)
            allow(controller).to receive(:policy_params).and_return(policy_io)
            allow(File).to receive(:open).with(Rails.root.join('public', 'uploads', policy_io.original_filename), 'wb').and_yield(policy_io)
            allow(File).to receive(:open).with("", "r").and_return(policy_io)
            expect(policy_io).to receive(:write).with("text")
            allow(policy_io).to receive(:close)
            controller.upload_file
        end
        
    end
    
    describe "delete_file" do
        
        it "deletes the original policy file if the file with filename from database exists" do
            controller.instance_variable_set(:@policy, @policy)
            allow(File).to receive(:exist?).and_return(true)
            expect(File).to receive(:delete).with(Rails.root.join('public', 'uploads', @policy.filename))
            controller.delete_file
        end
        
        it "does nothing if the file with filename from database doesn't exist" do 
            controller.instance_variable_set(:@policy, @policy)
            allow(File).to receive(:exist?).and_return(false)
            expect(File).not_to receive(:delete)
            controller.delete_file
        end
        
    end
    
end