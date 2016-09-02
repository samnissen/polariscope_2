class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_errors

  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :belongs_to_user, only: [:edit, :update, :destroy]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @testsets = Testset.where(collection: @collection)
    @runs = @collection.runs.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      prepare_errors
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:user_id, :name, :description)
    end

    def set_owner
      if @collection
        @owner ||= @collection.user
      else
        @owner = false
      end
    end

    def belongs_to_user
      # User must be unable to edit existing testsets they don't own
      # and also not create testsets in collections they don't own.
      unless ( @owner == current_user )
        error_message = 'You must be the owner to perform that action.'
        @collection.errors.add(:base, error_message) if @collection
        prepare_errors

        path ||= [@collection] if @collection
        path ||= collections_path if @collection

        redirect_to path and return
      end
    end

    def prepare_errors
      nil unless @collection && Array(@collection.errors).size > 0

      flash[:error] ||= []

      @collection.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end
end
