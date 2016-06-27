class TestActionsController < ApplicationController
  before_action :authenticate_user!
  before_action :reset_errors

  before_action :set_test_action, only: [:show, :edit, :update, :destroy]
  before_action :set_testset, only: [:show, :new, :create, :edit, :show, :update, :destroy, :change_order]
  before_action :set_owner

  before_action :belongs_to_user, only: [:new, :edit, :create, :update, :destroy]

  # GET /test_actions
  # GET /test_actions.json
  def index
    @testset = Testset.find_by_id("#{params[:testset_id]}".to_i)
    @test_actions = TestAction.where(user: current_user).order(:position).group_by(&:testset_grouping)
  end

  def copy
    @testset = Testset.find_by_id("#{params[:testset_id]}".to_i)

    Array(params[:test_action][:test_action_ids]).each do |ta_id|
      test_action = TestAction.find_by_id(ta_id)
      redirect_to [@testset.collection, @testset], notice: "Your Action ##{ta_id} could not be found." and return unless test_action

      new_test_action = TestAction.duplicate_action(test_action, current_user, @testset)
      redirect_to [@testset.collection, @testset], error: new_test_action.errors.full_messages and return unless new_test_action.save

      new_test_action.move_to_bottom
      new_test_action.save!
    end

    redirect_to [@testset.collection, @testset], notice: 'Actions successfully copied.'
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
    @test_action.user = current_user

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
        format.html { redirect_to [@test_action.testset.collection, @test_action.testset], notice: 'Test action was successfully updated.' }
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
    path = [@test_action.testset.collection, @test_action.testset]

    @test_action.destroy
    respond_to do |format|
      format.html { redirect_to path, notice: 'Test action was successfully destroyed.' }
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
      params.require(:test_action).permit(:name, :description, :pointer, :testset_id, :activity_id, :user_id)
    end

    def set_owner
      if @test_action
        @owner ||= @test_action.user
        @owner ||= @test_action.testset.user
      else
        @owner = @testset.user
      end
    end

    def belongs_to_user
      # User must be unable to edit existing testsets they don't own
      # and also not create testsets in collections they don't own.
      unless ( @owner == current_user )
        error_message = 'You must be the owner to perform that action.'
        @test_action.errors.add(:base, error_message)
        prepare_errors

        path   = [@test_action.testset.collection, @test_action.testset] if @test_action
        path ||= [@testset.collection, @testset]

        redirect_to path and return
      end
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
