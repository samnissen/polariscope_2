require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe RunTestActionsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # RunTestAction. As you add validations to RunTestAction, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RunTestActionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all run_test_actions as @run_test_actions" do
      run_test_action = RunTestAction.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:run_test_actions)).to eq([run_test_action])
    end
  end

  describe "GET #show" do
    it "assigns the requested run_test_action as @run_test_action" do
      run_test_action = RunTestAction.create! valid_attributes
      get :show, {:id => run_test_action.to_param}, valid_session
      expect(assigns(:run_test_action)).to eq(run_test_action)
    end
  end

  describe "GET #new" do
    it "assigns a new run_test_action as @run_test_action" do
      get :new, {}, valid_session
      expect(assigns(:run_test_action)).to be_a_new(RunTestAction)
    end
  end

  describe "GET #edit" do
    it "assigns the requested run_test_action as @run_test_action" do
      run_test_action = RunTestAction.create! valid_attributes
      get :edit, {:id => run_test_action.to_param}, valid_session
      expect(assigns(:run_test_action)).to eq(run_test_action)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RunTestAction" do
        expect {
          post :create, {:run_test_action => valid_attributes}, valid_session
        }.to change(RunTestAction, :count).by(1)
      end

      it "assigns a newly created run_test_action as @run_test_action" do
        post :create, {:run_test_action => valid_attributes}, valid_session
        expect(assigns(:run_test_action)).to be_a(RunTestAction)
        expect(assigns(:run_test_action)).to be_persisted
      end

      it "redirects to the created run_test_action" do
        post :create, {:run_test_action => valid_attributes}, valid_session
        expect(response).to redirect_to(RunTestAction.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved run_test_action as @run_test_action" do
        post :create, {:run_test_action => invalid_attributes}, valid_session
        expect(assigns(:run_test_action)).to be_a_new(RunTestAction)
      end

      it "re-renders the 'new' template" do
        post :create, {:run_test_action => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested run_test_action" do
        run_test_action = RunTestAction.create! valid_attributes
        put :update, {:id => run_test_action.to_param, :run_test_action => new_attributes}, valid_session
        run_test_action.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested run_test_action as @run_test_action" do
        run_test_action = RunTestAction.create! valid_attributes
        put :update, {:id => run_test_action.to_param, :run_test_action => valid_attributes}, valid_session
        expect(assigns(:run_test_action)).to eq(run_test_action)
      end

      it "redirects to the run_test_action" do
        run_test_action = RunTestAction.create! valid_attributes
        put :update, {:id => run_test_action.to_param, :run_test_action => valid_attributes}, valid_session
        expect(response).to redirect_to(run_test_action)
      end
    end

    context "with invalid params" do
      it "assigns the run_test_action as @run_test_action" do
        run_test_action = RunTestAction.create! valid_attributes
        put :update, {:id => run_test_action.to_param, :run_test_action => invalid_attributes}, valid_session
        expect(assigns(:run_test_action)).to eq(run_test_action)
      end

      it "re-renders the 'edit' template" do
        run_test_action = RunTestAction.create! valid_attributes
        put :update, {:id => run_test_action.to_param, :run_test_action => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested run_test_action" do
      run_test_action = RunTestAction.create! valid_attributes
      expect {
        delete :destroy, {:id => run_test_action.to_param}, valid_session
      }.to change(RunTestAction, :count).by(-1)
    end

    it "redirects to the run_test_actions list" do
      run_test_action = RunTestAction.create! valid_attributes
      delete :destroy, {:id => run_test_action.to_param}, valid_session
      expect(response).to redirect_to(run_test_actions_url)
    end
  end

end
