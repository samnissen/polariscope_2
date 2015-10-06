class EnvironmentsController < ApplicationController
  before_action :authenticate_user!

  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  before_filter :belongs_to_user, only: [:edit, :update, :destroy]

  # before_action :reset_errors

  # GET /environments
  # GET /environments.json
  def index
    @environments = Environment.where(user: current_user)
  end

  # GET /environments/1
  # GET /environments/1.json
  def show
  end

  # GET /environments/new
  def new
    @environment = Environment.new
  end

  # GET /environments/1/edit
  def edit
  end

  # POST /environments
  # POST /environments.json
  def create
    @environment = Environment.new(environment_params)
    @environment.user = current_user

    respond_to do |format|
      if @environment.save
        format.html { redirect_to environments_path, notice: 'Environment was successfully created.' }
        format.json { render :show, status: :created, location: @environment }
      else
        format.html { render :new }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environments/1
  # PATCH/PUT /environments/1.json
  def update
    respond_to do |format|
      if @environment.update(environment_params)
        format.html { redirect_to environments_path, notice: 'Environment was successfully updated.' }
        format.json { render :show, status: :ok, location: @environment }
      else
        format.html { render :edit }
        format.json { render json: @environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environments/1
  # DELETE /environments/1.json
  def destroy
    has_variables = stop_if_variables
    redirect_to @environment and return if has_variables

    @environment.destroy

    respond_to do |format|
      format.html { redirect_to environments_url, notice: 'Environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment
      @environment = Environment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environment_params
      params.require(:environment).permit(:name, :user_id)
    end

    def prepare_errors
      nil unless @environment && Array(@environment.errors).size > 0

      flash[:danger] ||= []

      @environment.errors.to_a.each do |err|
        flash[:danger] << err
      end
    end

    def reset_errors
      flash[:danger] = []
    end

    def belongs_to_user
      unless (@environment.user == current_user)
        error_message = 'You must be the owner to perform that action'
        @environment.errors.add(:base, error_message)
        prepare_errors
        redirect_to @environment and return
      end
    end

    def stop_if_variables
      if @environment.data_element_values.any?
        error_message = %{Please delete all variables assigned
          to this environment before proceeding.}.gsub(/\s+/, ' ').strip
        @environment.errors.add(:base, error_message)

        prepare_errors

        return true
      end
    end
end
