class ActionStatusesController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_filter :belongs_to_user, only: [:edit, :update, :destroy]

  before_action :reset_errors
  before_action :set_action_status, only: [:show, :edit, :update, :destroy]

  # GET /test_statuses
  # GET /test_statuses.json
  def index
    @action_statuses = ActionStatus.all
  end

  # GET /test_status/1
  # GET /test_status/1.json
  def show
    set_did_you_means
  end

  # GET /test_status/new
  def new
    @action_status = ActionStatus.new()
  end

  # GET /testsets/1/edit
  def edit
  end

  # POST /test_status
  # POST /test_status.json
  def create
    @action_status = ActionStatus.new(action_status_params)
    @action_status.user = current_user

    respond_to do |format|
      if @action_status.save
        format.html { redirect_to [@action_status.run_test.run.collection, @action_status.run_test.run], notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @action_status }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @action_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testsets/1
  # PATCH/PUT /testsets/1.json
  def update
    respond_to do |format|
      if @action_status.update(action_status_params)
        format.html { redirect_to [@action_status.run_test.run.collection, @action_status.run_test.run], notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @action_status }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @action_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testsets/1
  # DELETE /testsets/1.json
  # def destroy
    # @action_status.destroy
    # respond_to do |format|
      # format.html { redirect_to testsets_url, notice: 'Testset was successfully destroyed.' }
      # format.json { head :no_content }
    # end
  # end

  private
    def set_action_status
      @action_status = ActionStatus.find(params[:id])
    end

    def set_did_you_means
      @did_you_means = @action_status.did_you_means
    end

    def action_status_params
      params.require(:action_status).permit(:run_test_action_id, :browser_type_id, :success, :notes, :log)
    end

    def prepare_errors
      nil unless @action_status && Array(@action_status.errors).size > 0

      flash[:danger] ||= []

      @action_status.errors.to_a.each do |err|
        flash[:danger] << err.html_safe
      end
    end

    def reset_errors
      flash[:danger] = []
    end

    def belongs_to_user
      unless (@action_status.user == current_user)
        error_message = 'You must be the owner to perform that action'
        @action_status.errors.add(:base, error_message)
        prepare_errors
        redirect_to @action_status and return
      end
    end
end
