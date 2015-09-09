class ObjectIdentifierSiblingsController < ApplicationController

  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_filter :belongs_to_user, only: [:edit, :update, :destroy]

  before_action :set_object_identifier_sibling, only: [:show, :edit, :update, :destroy]

  before_action :reset_errors

  # GET /object_identifier_siblings
  # GET /object_identifier_siblings.json
  def index
    @object_identifier_siblings = ObjectIdentifierSibling.all
  end

  # GET /object_identifier_siblings/1
  # GET /object_identifier_siblings/1.json
  def show
  end

  # GET /object_identifier_siblings/new
  def new
    @object_identifier_sibling = ObjectIdentifierSibling.new(object_identifier_id: params["object_identifier_id"])
  end

  # GET /object_identifier_siblings/1/edit
  def edit
  end

  # POST /object_identifier_siblings
  # POST /object_identifier_siblings.json
  def create
    @object_identifier_sibling = ObjectIdentifierSibling.new(object_identifier_sibling_params)
    @object_identifier_sibling.user = current_user

    respond_to do |format|
      if @object_identifier_sibling.save
        format.html { redirect_to [@object_identifier_sibling.object_identifier.test_action.testset.collection, @object_identifier_sibling.object_identifier.test_action.testset, @object_identifier_sibling.object_identifier.test_action], notice: 'Object identifier sibling was successfully created.' }
        format.json { render :show, status: :created, location: @object_identifier_sibling }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @object_identifier_sibling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /object_identifier_siblings/1
  # PATCH/PUT /object_identifier_siblings/1.json
  def update
    respond_to do |format|
      if @object_identifier_sibling.update(object_identifier_sibling_params)
        format.html { redirect_to [@object_identifier_sibling.object_identifier.test_action.testset.collection, @object_identifier_sibling.object_identifier.test_action.testset, @object_identifier_sibling.object_identifier.test_action], notice: 'Object identifier sibling was successfully updated.' }
        format.json { render :show, status: :ok, location: @object_identifier_sibling }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @object_identifier_sibling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_identifier_siblings/1
  # DELETE /object_identifier_siblings/1.json
  def destroy
    @object_identifier_sibling.destroy
    respond_to do |format|
      format.html { redirect_to object_identifier_siblings_url, notice: 'Object identifier sibling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_identifier_sibling
      @object_identifier_sibling = ObjectIdentifierSibling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def object_identifier_sibling_params
      params.require(:object_identifier_sibling).permit(:identifier, :object_type_id, :selector_id, :object_identifier_id, :sibling_relationship_id, :user_id)
    end

    def prepare_errors
      nil unless @object_identifier_sibling && Array(@object_identifier_sibling.errors).size > 0

      flash[:error] ||= []

      @object_identifier_sibling.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def belongs_to_user
      @object_identifier_sibling.errors << 'You must be the owner to perform that action'
      prepare_errors
      redirect_to @object_identifier_sibling and return unless (@object_identifier_sibling.user == current_user)
    end
end
