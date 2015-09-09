class TestActionsController < ApplicationController
  before_action :set_test_action, only: [:show, :edit, :update, :destroy]
  before_action :set_testset
  before_action :reset_errors

  # GET /test_actions
  # GET /test_actions.json
  def index
    @test_actions = TestAction.all
  end

  # GET /test_actions/1
  # GET /test_actions/1.json
  def show
  end

  # GET /test_actions/new
  def new
    @test_action = TestAction.new
  end

  # GET /test_actions/1/edit
  def edit
  end

  # POST /test_actions
  # POST /test_actions.json
  def create
    @test_action = TestAction.new(test_action_params)

    puts " -- !!! -- >>> test_action_params: #{test_action_params}"

    respond_to do |format|
      if @test_action.save
        format.html { redirect_to [@test_action.testset.collection, @test_action.testset], notice: 'Test action was successfully created.' }
        format.json { render :show, status: :created, location: @test_action }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @test_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_actions/1
  # PATCH/PUT /test_actions/1.json
  def update
    respond_to do |format|
      if @test_action.update(test_action_params)
        format.html { redirect_to @test_action, notice: 'Test action was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_action }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @test_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_actions/1
  # DELETE /test_actions/1.json
  def destroy
    @test_action.destroy
    respond_to do |format|
      format.html { redirect_to test_actions_url, notice: 'Test action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_action
      @test_action = TestAction.find(params[:id])
    end

    def set_testset
      @testset = Testset.find(params[:testset_id])
      @testset ||= @test_action.testset
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_action_params
      params.require(:test_action).permit(:name, :description, :testset_id, :activity_id, :additional_info, :user_id)
    end

    def prepare_errors
      nil unless @test_action && Array(@test_action.errors).size > 0

      flash[:error] ||= []

      @test_action.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end
end
