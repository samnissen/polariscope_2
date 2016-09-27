class ObjectIdentifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_errors

  before_action :set_object_identifier, only: [:show, :edit, :update, :destroy]
  before_action :set_test_action, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_owner, only: [:show, :new, :create, :edit, :update, :destroy]

  before_action :belongs_to_user, only: [:new, :create, :update, :destroy]
  # Removed :edit from the above since it acts as the 'Show' view as well

  # GET /object_identifiers
  # GET /object_identifiers.json
  def index
    @object_identifiers = ObjectIdentifier.all
  end

  # GET /object_identifiers/1
  # GET /object_identifiers/1.json
  def show
    redirect_to [ @object_identifier.test_action.testset.collection,
                  @object_identifier.test_action.testset ] and return
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
        prepare_errors(@object_identifier)
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
        prepare_errors(@object_identifier)
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

    def set_test_action
      @test_action = TestAction.find(params[:test_action_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def object_identifier_params
      params.require(:object_identifier).permit(:identifier, :test_action_id, :object_type_id, :selector_id, :user_id)
    end

    def prepare_errors(err_instance)
      nil unless err_instance && Array(err_instance.errors).size > 0

      flash[:error] ||= []

      err_instance.errors.to_a.each do |err|
        flash[:error] << err
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def set_owner
      if @object_identifier
        @owner   = @object_identifier.user
        @owner ||= @object_identifier.test_action.user
        @owner ||= @object_identifier.test_action.testset.user
      else
        @owner   = @test_action.user
        @owner ||= @test_action.testset.user
      end
    end

    def belongs_to_user
      # User must be unable to edit existing testsets they don't own
      # and also not create testsets in collections they don't own.
      unless ( @owner == current_user )
        error_message = 'You must be the owner to perform that action.'
        if @object_identifier.nil?
          @test_action.errors.add(:base, error_message)
          prepare_errors(@test_action)
        else
          @object_identifier.errors.add(:base, error_message)
          prepare_errors(@object_identifier)
        end

        path   = [@object_identifier.test_action.testset.collection, @object_identifier.test_action.testset] if @object_identifier
        path ||= [@test_action.testset.collection, @test_action.testset]

        redirect_to path and return
      end
    end
end
