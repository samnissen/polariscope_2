class ObjectIdentifierSiblingsController < ApplicationController
  before_action :authenticate_user!

  before_action :reset_errors

  before_action :set_object_identifier_sibling, only: [:show, :edit, :update, :destroy]
  before_action :set_object_identifier, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_owner, only: [:show, :new, :create, :edit, :update, :destroy]

  before_action :belongs_to_user, only: [:new, :create, :update, :destroy]
  # Removed :edit from the above since it acts as the 'Show' view as well

  before_filter :set_objects_and_selectors, only: [:new, :edit]

  # GET /object_identifier_siblings
  # GET /object_identifier_siblings.json
  # def index
    # @object_identifier_siblings = ObjectIdentifierSibling.all
  # end

  # GET /object_identifier_siblings/1
  # GET /object_identifier_siblings/1.json
  # def show
  # end

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
        format.html { redirect_to [@object_identifier_sibling.object_identifier.test_action.testset.collection, @object_identifier_sibling.object_identifier.test_action.testset], notice: 'Object identifier relation was successfully created.' }
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
        format.html { redirect_to [@object_identifier_sibling.object_identifier.test_action.testset.collection, @object_identifier_sibling.object_identifier.test_action.testset], notice: 'Object identifier relation was successfully updated.' }
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
    path = collection_testset_path(@object_identifier_sibling.object_identifier.test_action.testset.collection, @object_identifier_sibling.object_identifier.test_action.testset)

    @object_identifier_sibling.destroy
    respond_to do |format|
      format.html { redirect_to path, notice: 'Object identifier sibling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_object_identifier_sibling
      @object_identifier_sibling = ObjectIdentifierSibling.find(params[:id])
    end

    def set_object_identifier
      @object_identifier = ObjectIdentifier.find(params[:object_identifier_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def object_identifier_sibling_params
      params.require(:object_identifier_sibling).permit(:identifier, :object_type_id, :selector_id, :object_identifier_id, :sibling_relationship_id, :user_id)
    end

    def set_objects_and_selectors
      @object_types = ObjectType.where.not("type_name = ?", 'n/a')
      @selectors = Selector.where.not("selector_name = ?", 'n/a')
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
      if @object_identifier_sibling
        @owner   = @object_identifier_sibling.user
        @owner ||= @object_identifier_sibling.object_identifier.user
        @owner ||= @object_identifier_sibling.object_identifier.test_action.user
        @owner ||= @object_identifier_sibling.object_identifier.test_action.testset.user
      else
        @owner   = @object_identifier.user
        @owner ||= @object_identifier.test_action.user
        @owner ||= @object_identifier.test_action.testset.user
      end
    end

    def belongs_to_user
      # User must be unable to edit existing testsets they don't own
      # and also not create testsets in collections they don't own.
      unless ( @owner == current_user )
        error_message = 'You must be the owner to perform that action.'
        if @object_identifier_sibling.nil?
          @object_identifier.errors.add(:base, error_message)
          prepare_errors(@object_identifier)
        else
          @object_identifier_sibling.errors.add(:base, error_message)
          prepare_errors(@object_identifier_sibling)
        end

        path = [  @object_identifier_sibling.object_identifier.test_action.testset.collection,
                  @object_identifier_sibling.object_identifier.test_action.testset ] if @object_identifier_sibling

        path = [  @object_identifier.test_action.testset.collection,
                  @object_identifier.test_action.testset ]

        redirect_to path and return
      end
    end
end
