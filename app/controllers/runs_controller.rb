class RunsController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_run, only: [:show, :edit, :update, :destroy]

  before_action :reset_errors

  # GET /runs
  # GET /runs.json
  # def index
    # @runs = Run.all
  # end

  # GET /runs/1
  # GET /runs/1.json
  def show
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  # def edit
  # end

  # POST /runs
  # POST /runs.json
  def create
    has_tests = check_collection_has_tests
    render json: ['Please create at least one test'], status: :unprocessable_entity and return unless has_tests

    has_variables = check_owners_have_variables
    render json: ['You must have variables used in the tests to proceed'], status: :unprocessable_entity and return unless has_variables

    @run = Run.new(run_params)

    respond_to do |format|
      if @run.save
        format.html { redirect_to [@run.collection, @run], notice: 'Run was successfully created.' }
        format.json { render :show, status: :created, location: [@run.collection, @run] }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  # def update
    # respond_to do |format|
      # if @run.update(run_params)
        # format.html { redirect_to @run, notice: 'Run was successfully updated.' }
        # format.json { render :show, status: :ok, location: @run }
      # else
        # format.html { render :edit }
        # format.json { render json: @run.errors, status: :unprocessable_entity }
      # end
    # end
  # end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    path = @run.collection

    @run.destroy
    respond_to do |format|
      format.html { redirect_to path, notice: 'Run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_action_status
    action_statusbtn_id = params[:status_action_id]
    action_statusbtn_id = /\d+/.match(action_statusbtn_id) #strip the rta id from the status button identifier
    rta = RunTestAction.find(action_statusbtn_id.to_s) #had to convert to string value for find to work
    render :partial => "runs/status_icon", :locals => { :rta => rta }
  end

  def update_run_status
    run_statusbtn_id = params[:test_status_id]
    run_statusbtn_id = /\d+/.match(run_statusbtn_id)
    run_test = RunTest.find(run_statusbtn_id.to_s)
    render :partial => "runs/run_status", :locals => { :run_test => run_test }
  end


  private
    def check_collection_has_tests
      c = Collection.find(run_params[:collection_id])
      return c.testsets.any?
    end

    def check_owners_have_variables
      # UGH. There HAS to be a more efficient way to do this.
      # This is a protection against attempting to run
      # tests where the creator used a variable
      # that the current execturor does not have.
      matching_variables = run_params[:test_ids].map { |test_id|
        Testset.find(test_id).test_actions.map { |test_action|
          next unless test_action.object_identifier && test_action.object_identifier.test_action_data
          test_action.object_identifier.test_action_data.map { |datum|
            datum.data_element && datum.data_element.data_element_values.where(environment_id: run_params[:environment_id]).any?
          }
        }
      }.flatten.compact

      # Either the user should have all relevant data values
      # OR the user should have no values at all.
      return matching_variables.all? || matching_variables.empty?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(:name, :description, :collection_id, :environment_id, :test_ids => [], :browsers => [])
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
