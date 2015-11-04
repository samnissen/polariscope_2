class ObjectIdentifiersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_object_identifier, only: [:show, :edit, :update, :destroy]

  before_action :reset_errors

  # GET /object_identifiers
  # GET /object_identifiers.json
  def index
    @object_identifiers = ObjectIdentifier.all
  end

  # GET /object_identifiers/1
  # GET /object_identifiers/1.json
  def show
  end

  # GET /object_identifiers/new
  def new
    @object_identifier = ObjectIdentifier.new(test_action_id: params["test_action_id"])
  end

  # GET /object_identifiers/1/edit
  def edit
  end

  # POST /object_identifiers
  # POST /object_identifiers.json
  def create
    @object_identifier = ObjectIdentifier.new(object_identifier_params)
    @object_identifier.event_type = params[:object_identifier][:event_name]
    @object_identifier.user = current_user

    respond_to do |format|
      if @object_identifier.save
        format.html { redirect_to [@object_identifier.test_action.testset.collection, @object_identifier.test_action.testset], notice: 'Object identifier was successfully created.' }
        format.json { render :show, status: :created, location: @object_identifier }
      else
        format.html { render :new }
        format.json { render json: @object_identifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /object_identifiers/1
  # PATCH/PUT /object_identifiers/1.json
  def update
    respond_to do |format|
      if @object_identifier.update(object_identifier_params)
        @object_identifier.event_type = params[:object_identifier][:event_name]
        format.html { redirect_to [@object_identifier.test_action.testset.collection, @object_identifier.test_action.testset], notice: 'Object identifier was successfully updated.' }
        format.json { render :show, status: :ok, location: @object_identifier }
      else
        format.html { render :edit }
        format.json { render json: @object_identifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /object_identifiers/1
  # DELETE /object_identifiers/1.json
  def destroy
    @object_identifier.destroy
    respond_to do |format|
      format.html { redirect_to [@object_identifier.test_action.testset.collection, @object_identifier.test_action.testset], notice: 'Object identifier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_identifier
      @object_identifier = ObjectIdentifier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def object_identifier_params
      params.require(:object_identifier).permit(:identifier, :test_action_id, :object_type_id, :selector_id, :user_id)
    end

    def prepare_errors
      puts "@object_identifier.errors: #{@object_identifier.errors}"
      nil unless @object_identifier && Array(@object_identifier.errors).size > 0

      flash[:error] ||= []

      @object_identifier.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def belongs_to_user
      @object_identifier.errors << 'You must be the owner to perform that action'
      prepare_errors
      redirect_to @object_identifier and return unless (@object_identifier.user == current_user)
    end
end
