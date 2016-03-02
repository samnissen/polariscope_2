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

RSpec.describe ObjectIdentifierSiblingsController, type: :controller do

  before(:all) do
    @user = create(:user)
    @non_owner = create(:user, email: "#{SecureRandom.hex}@rakuten.com")

    @collection = create(:collection)
    @testset = create(:testset)
    @test_action = create(:test_action)
    @object_identifier = create(:object_identifier)
  end

  let(:nested_resources) {
    {
      :collection_id => @collection.id,
      :testset_id => @testset.id,
      :test_action_id => @test_action.id,
      :object_identifier_id => @object_identifier.id
    }
  }

  # This should return the minimal set of attributes required to create a valid
  # ObjectIdentifierSibling. As you add validations to ObjectIdentifierSibling, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      :identifier => "some-string",
      :object_type => create(:object_type),
      :selector => create(:selector),
      :object_identifier => create(:object_identifier),
      :sibling_relationship => create(:sibling_relationship),
      :user => @user
    }
  }

  let(:invalid_attributes) {
    {
      :identifier => nil,
      :object_type_id => nil,
      :selector_id => nil,
      :object_identifier_id => nil,
      :sibling_relationship_id => nil,
      :user_id => nil
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ObjectIdentifierSiblingsController. Be sure to keep this updated too.
  let(:valid_session) { { 'user[email]' => @user.email, 'user[password]' => @user.password } }

  # let (:user) { create(:user) }

  context "with valid access" do
    before(:each) do
      sign_in @user
    end

    describe "GET #new" do
      it "assigns a new object_identifier_sibling as @object_identifier_sibling" do
        get :new, {}.merge(nested_resources), valid_session
        expect(assigns(:object_identifier_sibling)).to be_a_new(ObjectIdentifierSibling)
      end
    end

    describe "GET #edit" do
      it "assigns the requested object_identifier_sibling as @object_identifier_sibling" do
        object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
        get :edit, {:id => object_identifier_sibling.to_param}.merge(nested_resources), valid_session
        expect(assigns(:object_identifier_sibling)).to eq(object_identifier_sibling)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new ObjectIdentifierSibling" do
          expect {
            post :create, {:object_identifier_sibling => valid_attributes}.merge(nested_resources), valid_session
          }.to change(ObjectIdentifierSibling, :count).by(1)
        end

        it "assigns a newly created object_identifier_sibling as @object_identifier_sibling" do
          post :create, {:object_identifier_sibling => valid_attributes}.merge(nested_resources), valid_session
          expect(assigns(:object_identifier_sibling)).to be_a(ObjectIdentifierSibling)
          expect(assigns(:object_identifier_sibling)).to be_persisted
        end

        it "redirects to the created object_identifier_sibling" do
          post :create, {:object_identifier_sibling => valid_attributes}.merge(nested_resources), valid_session
          expect(response).to redirect_to(collection_testset_path(ObjectIdentifierSibling.last.object_identifier.test_action.testset.collection, ObjectIdentifierSibling.last.object_identifier.test_action.testset))
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved object_identifier_sibling as @object_identifier_sibling" do
          post :create, {:object_identifier_sibling => invalid_attributes}.merge(nested_resources), valid_session
          expect(assigns(:object_identifier_sibling)).to be_a_new(ObjectIdentifierSibling)
        end

        it "re-renders the 'new' template" do
          post :create, {:object_identifier_sibling => invalid_attributes}.merge(nested_resources), valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            :identifier => "some-totally-new-string",
            :object_type => create(:object_type),
            :selector => create(:selector),
            :object_identifier => create(:object_identifier),
            :sibling_relationship => create(:sibling_relationship)
          }
        }

        it "updates the requested object_identifier_sibling" do
          object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
          put :update, {:id => object_identifier_sibling.to_param, :object_identifier_sibling => new_attributes}.merge(nested_resources), valid_session
          object_identifier_sibling.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested object_identifier_sibling as @object_identifier_sibling" do
          object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
          put :update, {:id => object_identifier_sibling.to_param, :object_identifier_sibling => valid_attributes}.merge(nested_resources), valid_session
          expect(assigns(:object_identifier_sibling)).to eq(object_identifier_sibling)
        end

        it "redirects to the object_identifier_sibling" do
          object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
          put :update, {:id => object_identifier_sibling.to_param, :object_identifier_sibling => valid_attributes}.merge(nested_resources), valid_session

          redirect_testset = object_identifier_sibling.object_identifier.test_action.testset
          redirect_collection = redirect_testset.collection
          expect(response).to redirect_to(collection_testset_path(redirect_collection, redirect_testset))
        end
      end

      context "with invalid params" do
        it "assigns the object_identifier_sibling as @object_identifier_sibling" do
          object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
          put :update, {:id => object_identifier_sibling.to_param, :object_identifier_sibling => invalid_attributes}.merge(nested_resources), valid_session
          expect(assigns(:object_identifier_sibling)).to eq(object_identifier_sibling)
        end

        it "re-renders the 'edit' template" do
          object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
          put :update, {:id => object_identifier_sibling.to_param, :object_identifier_sibling => invalid_attributes}.merge(nested_resources), valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested object_identifier_sibling" do
        object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
        expect {
          delete :destroy, {:id => object_identifier_sibling.to_param}.merge(nested_resources), valid_session
        }.to change(ObjectIdentifierSibling, :count).by(-1)
      end

      it "redirects to the testset" do
        object_identifier_sibling = ObjectIdentifierSibling.create! valid_attributes
        redirect_testset = object_identifier_sibling.object_identifier.test_action.testset
        redirect_collection = redirect_testset.collection

        delete :destroy, {:id => object_identifier_sibling.to_param}.merge(nested_resources), valid_session
        expect(response).to redirect_to(collection_testset_path(redirect_collection, redirect_testset))
      end
    end
  end

  context "without valid access" do

  end

end
