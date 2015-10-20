class RunObjectIdentifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_run_object_identifer, only: [:show, :edit, :update, :destroy]

  # GET /run_object_identifers
  # GET /run_object_identifers.json
  def index
    @run_object_identifers = RunObjectIdentifier.all
  end

  # GET /run_object_identifers/1
  # GET /run_object_identifers/1.json
  def show
  end

  # GET /run_object_identifers/new
  def new
    @run_object_identifer = RunObjectIdentifier.new
  end

  # GET /run_object_identifers/1/edit
  def edit
  end

  # POST /run_object_identifers
  # POST /run_object_identifers.json
  def create
    @run_object_identifer = RunObjectIdentifier.new(run_object_identifer_params)

    respond_to do |format|
      if @run_object_identifer.save
        format.html { redirect_to @run_object_identifer, notice: 'Run object identifer was successfully created.' }
        format.json { render :show, status: :created, location: @run_object_identifer }
      else
        format.html { render :new }
        format.json { render json: @run_object_identifer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /run_object_identifers/1
  # PATCH/PUT /run_object_identifers/1.json
  def update
    respond_to do |format|
      if @run_object_identifer.update(run_object_identifer_params)
        format.html { redirect_to @run_object_identifer, notice: 'Run object identifer was successfully updated.' }
        format.json { render :show, status: :ok, location: @run_object_identifer }
      else
        format.html { render :edit }
        format.json { render json: @run_object_identifer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /run_object_identifers/1
  # DELETE /run_object_identifers/1.json
  def destroy
    @run_object_identifer.destroy
    respond_to do |format|
      format.html { redirect_to run_object_identifers_url, notice: 'Run object identifer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run_object_identifer
      @run_object_identifer = RunObjectIdentifier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_object_identifer_params
      params.require(:run_object_identifer).permit(:identifier, :id_type, :selector, :run_test_action_id)
    end
end
