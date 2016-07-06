class TestsetsController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_errors

  before_action :set_testset, only: [:show, :edit, :show, :update, :destroy, :change_order]

  before_action :set_collection, only: [:index, :new, :show, :edit, :update, :destroy, :change_order]
  before_action :set_owner, only: [:show, :new, :edit, :show, :update, :destroy, :change_order]

  before_action :set_collection, only: [:index, :new, :create, :show, :edit, :update, :destroy, :change_order]
  before_action :set_owner, only: [:show, :new, :edit, :create, :show, :update, :destroy, :change_order]


  before_action :belongs_to_user, only: [:new, :edit, :create, :update, :destroy, :change_order]

  # GET /testsets
  # GET /testsets.json
  def index
    # @testsets = Testset.all
    redirect_to [@collection] and return
  end

  def change_order
    ### JS code creating records
    # updatedData.push({
      # test_action_id: testActionId,
      # previous_order: i,
      # new_order: adjusted_order,
      # collection_id: collectionId,
      # testset_id: testsetId
    # });
    ###

    params.require(:steps_to_sort).each do |k,v|
      ta = TestAction.where(id: v[:id]).first

      change_order_error(v[:id]) unless ta

      ta.insert_at(v[:new_order].to_i)
      ta.save!
    end

    render :nothing => true

    # redirect_to [@collection, @testset] and return
  end

  # GET /testsets/1
  # GET /testsets/1.json
  def show
    @test_actions = TestAction.where(testset: @testset).order(position: :asc)
  end

  # GET /testsets/new
  def new
    @testset = Testset.new(collection_id: params[:collection_id])
  end

  # GET /testsets/1/edit
  def edit
  end

  # POST /testsets
  # POST /testsets.json
  def create
    @testset = Testset.new(testset_params)
    @testset.user = current_user
    set_collection

    respond_to do |format|
      if @testset.save
        format.html { redirect_to [@testset.collection, @testset], notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @testset }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @testset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testsets/1
  # PATCH/PUT /testsets/1.json
  def update
    respond_to do |format|
      if @testset.update(testset_params)
        format.html { redirect_to [@collection, @testset], notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @testset }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @testset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testsets/1
  # DELETE /testsets/1.json
  def destroy
    respond_to do |format|
      if @testset.destroy
        format.html { redirect_to [@collection], notice: 'Testset was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to [@collection, @testset], alert: @testset.errors.full_messages   }
        format.json { render json: @testset.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testset
      @testset = Testset.find(params[:id])
    end

    def set_collection
      @collection = Collection.find(params[:collection_id]) if params[:collection_id]
      @collection ||= @testset.collection

      @testset.collection = @collection if @testset
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def testset_params
      params.require(:testset).permit(:name, :description, :collection_id, :user_id)
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
      if @testset
        @owner ||= @testset.user
        @owner ||= @testset.collection.user
      else
        @owner = @collection.user
      end
    end

    def belongs_to_user
      # User must be unable to edit existing testsets they don't own
      # and also not create testsets in collections they don't own.
      unless ( @owner == current_user )
        error_message = 'You must be the owner to perform that action.'
        if @testset.nil?
          @collection.errors.add(:base, error_message)
          prepare_errors(@collection)
        else
          @testset.errors.add(:base, error_message)
          prepare_errors(@testset)
        end

        path   = [@testset.collection, @testset] if @testset
        path ||= [@collection]

        redirect_to path and return
      end
    end

    def change_order_error
      reset_errors

      @testset.errors[:base] << 'Unable to reorder test steps. Please try again'
      prepare_errors

      redirect_to [@collection, @testset] and return
    end
end
