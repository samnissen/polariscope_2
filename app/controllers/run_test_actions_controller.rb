class RunTestActionsController < ApplicationController
  before_action :set_run_test_action, only: [:show, :edit, :update, :destroy]

  # GET /run_test_actions
  # GET /run_test_actions.json
  def index
    @run_test_actions = RunTestAction.all
  end

  # GET /run_test_actions/1
  # GET /run_test_actions/1.json
  def show
  end

  # GET /run_test_actions/new
  def new
    @run_test_action = RunTestAction.new
  end

  # GET /run_test_actions/1/edit
  def edit
  end

  # POST /run_test_actions
  # POST /run_test_actions.json
  def create
    @run_test_action = RunTestAction.new(run_test_action_params)

    respond_to do |format|
      if @run_test_action.save
        format.html { redirect_to @run_test_action, notice: 'Run test action was successfully created.' }
        format.json { render :show, status: :created, location: @run_test_action }
      else
        format.html { render :new }
        format.json { render json: @run_test_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /run_test_actions/1
  # PATCH/PUT /run_test_actions/1.json
  def update
    respond_to do |format|
      if @run_test_action.update(run_test_action_params)
        format.html { redirect_to @run_test_action, notice: 'Run test action was successfully updated.' }
        format.json { render :show, status: :ok, location: @run_test_action }
      else
        format.html { render :edit }
        format.json { render json: @run_test_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /run_test_actions/1
  # DELETE /run_test_actions/1.json
  def destroy
    @run_test_action.destroy
    respond_to do |format|
      format.html { redirect_to run_test_actions_url, notice: 'Run test action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run_test_action
      @run_test_action = RunTestAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_test_action_params
      params.require(:run_test_action).permit(:name, :description, :test_action_id, :run_id, :activity_id, :additional_info)
    end
end
