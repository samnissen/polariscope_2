class TestStatusesController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_filter :belongs_to_user, only: [:edit, :update, :destroy]

  before_action :reset_errors
  before_action :set_test_status, only: [:show, :edit, :update, :destroy]

  # GET /test_statuses
  # GET /test_statuses.json
  def index
    @test_statuses = TestStatus.all
  end

  # GET /test_status/1
  # GET /test_status/1.json
  def show
  end

  # GET /test_status/new
  def new
    @test_status = TestStatus.new()
  end

  # GET /testsets/1/edit
  def edit
  end

  # POST /test_status
  # POST /test_status.json
  def create
    @test_status = TestStatus.new(test_status_params)
    @test_status.user = current_user

    respond_to do |format|
      if @test_status.save
        format.html { redirect_to [@test_status.run_test.run.collection, @test_status.run_test.run], notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test_status }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @test_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testsets/1
  # PATCH/PUT /testsets/1.json
  def update
    respond_to do |format|
      if @test_status.update(test_status_params)
        format.html { redirect_to [@test_status.run_test.run.collection, @test_status.run_test.run], notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_status }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @test_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testsets/1
  # DELETE /testsets/1.json
  # def destroy
    # @test_status.destroy
    # respond_to do |format|
      # format.html { redirect_to testsets_url, notice: 'Testset was successfully destroyed.' }
      # format.json { head :no_content }
    # end
  # end

  private
    def set_test_status
      @test_status = TestStatus.find(params[:id])
    end

    def test_status_params
      params.require(:test_status).permit(:run_test_id, :browser_type_id, :success, :notes, :log)
    end

    def prepare_errors
      nil unless @test_status && Array(@test_status.errors).size > 0

      flash[:danger] ||= []

      @test_status.errors.to_a.each do |err|
        flash[:danger] << err.html_safe
      end
    end

    def reset_errors
      flash[:danger] = []
    end

    def belongs_to_user
      unless (@test_status.user == current_user)
        error_message = 'You must be the owner to perform that action'
        @test_status.errors.add(:base, error_message)
        prepare_errors
        redirect_to @test_status and return
      end
    end
end
