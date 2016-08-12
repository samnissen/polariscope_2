class TestActionDataController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_test_action_datum, only: [:show, :edit, :update, :destroy]
  before_action :set_collections, only: [:new, :create, :edit, :update, :destroy]

  before_action :reset_errors

  # GET /test_actions
  # GET /test_actions.json
  def index
    @test_action_data = TestActionDatum.all
  end

  # GET /test_actions/1
  # GET /test_actions/1.json
  def show
  end

  # GET /test_actions/new
  def new
    @test_action_datum = TestActionDatum.new({:object_identifier_id => params[:object_identifier_id]})
  end

  # GET /test_actions/1/edit
  def edit
  end

  # POST /test_actions
  # POST /test_actions.json
  def create
    @test_action_datum = TestActionDatum.new(test_action_datum_params)

    respond_to do |format|
      if @test_action_datum.save
        format.html { redirect_to edit_collection_testset_test_action_object_identifier_path(@test_action_datum.object_identifier.test_action.testset.collection, @test_action_datum.object_identifier.test_action.testset, @test_action_datum.object_identifier.test_action, @test_action_datum.object_identifier), notice: 'Test action data was successfully created.' }
        format.json { render :show, status: :created, location: @test_action_datum }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @test_action_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_actions/1
  # PATCH/PUT /test_actions/1.json
  def update
    respond_to do |format|
      if @test_action_datum.update(test_action_datum_params)
        format.html { redirect_to edit_collection_testset_test_action_object_identifier_path(@test_action_datum.object_identifier.test_action.testset.collection, @test_action_datum.object_identifier.test_action.testset, @test_action_datum.object_identifier.test_action, @test_action_datum.object_identifier), notice: 'Test action data was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_action_datum }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @test_action_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_actions/1
  # DELETE /test_actions/1.json
  def destroy
    path = edit_collection_testset_test_action_object_identifier_path(@test_action_datum.object_identifier.test_action.testset.collection, @test_action_datum.object_identifier.test_action.testset, @test_action_datum.object_identifier.test_action, @test_action_datum.object_identifier)

    @test_action_datum.destroy
    respond_to do |format|
      format.html { redirect_to path, notice: 'Test action data was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_action_datum
      @test_action_datum = TestActionDatum.find(params[:id])
    end

    def set_collections
      @environments = Environment.where(user: current_user).order('name ASC')
      @variables = DataElement.where(user: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_action_datum_params
      params.require(:test_action_datum).permit(:data, :data_element_id, :object_identifier_id)
    end

    def prepare_errors
      nil unless @test_action_datum && Array(@test_action_datum.errors).size > 0

      flash[:error] ||= []

      @test_action_datum.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

end
