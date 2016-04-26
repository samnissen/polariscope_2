class ScheduledTestsController < InheritedResources::Base
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_scheduled_test, only: [:show, :edit, :update, :destroy]
  before_filter :belongs_to_user, only: [:edit, :update, :destroy]
  before_action :reset_errors

  # GET /scheduled_tests
  # GET /scheduled_tests.json
  def index
    @scheduled_tests = ScheduledTest.where(user: current_user)
  end

  # GET /scheduled_tests/1
  # GET /scheduled_tests/1.json
  # def show
  # end

  # GET /scheduled_tests/new
  def new
    @scheduled_test = ScheduledTest.new
  end

  # GET /scheduled_tests/1/edit
  def edit
  end

  # POST /scheduled_tests
  # POST /scheduled_tests.json
  def create
    puts "\n\n\n---->\tparams is #{params.inspect}\n"

    @scheduled_test = ScheduledTest.new(scheduled_test_params)
    @scheduled_test.user = current_user

    puts "\n---->\t@scheduled_test is #{@scheduled_test.inspect}\n\n\n"

    respond_to do |format|
      if @scheduled_test.save
        format.html { redirect_to scheduled_tests_path, notice: 'Scheduled test was successfully created.' }
        format.json { render :show, status: :created, location: @scheduled_test }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @scheduled_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scheduled_tests/1
  # PATCH/PUT /scheduled_tests/1.json
  def update
    puts "\n\n\n---->\tupdate params is #{params.inspect}\n"
    puts "\n---->\t@scheduled_test is #{@scheduled_test.inspect}\n\n\n"
    respond_to do |format|
      if @scheduled_test.update(scheduled_test_params)
        format.html { redirect_to scheduled_tests_path, notice: 'Scheduled test was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduled_test }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @scheduled_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_tests/1
  # DELETE /scheduled_tests/1.json
  def destroy
    @scheduled_test.destroy
    respond_to do |format|
      format.html { redirect_to scheduled_tests_path, notice: 'Scheduled test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduled_test
      @scheduled_test = ScheduledTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheduled_test_params
      params.require(:scheduled_test).permit(:notes, :collection_id, { :test_ids => [] }, :next_test, :recurring, :environment_id, { :browser_ids => [] })
    end

    def prepare_errors
      nil unless @scheduled_test && Array(@scheduled_test.errors).size > 0

      flash[:error] ||= []

      @scheduled_test.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def belongs_to_user
      return true if (@scheduled_test.user == current_user)

      @scheduled_test.errors.add(:base, 'You must be the owner to perform that action')
      prepare_errors
      redirect_to scheduled_tests_path and return
    end
end
