class RunObjectIdentifierSiblingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_run_object_identifer_sibling, only: [:show, :edit, :update, :destroy]

  # GET /run_object_identifer_siblings
  # GET /run_object_identifer_siblings.json
  def index
    @run_object_identifer_siblings = RunObjectIdentifierSibling.all
  end

  # GET /run_object_identifer_siblings/1
  # GET /run_object_identifer_siblings/1.json
  def show
  end

  # GET /run_object_identifer_siblings/new
  def new
    @run_object_identifer_sibling = RunObjectIdentifierSibling.new
  end

  # GET /run_object_identifer_siblings/1/edit
  def edit
  end

  # POST /run_object_identifer_siblings
  # POST /run_object_identifer_siblings.json
  def create
    @run_object_identifer_sibling = RunObjectIdentifierSibling.new(run_object_identifer_sibling_params)

    respond_to do |format|
      if @run_object_identifer_sibling.save
        format.html { redirect_to @run_object_identifer_sibling, notice: 'Run object identifer sibling was successfully created.' }
        format.json { render :show, status: :created, location: @run_object_identifer_sibling }
      else
        format.html { render :new }
        format.json { render json: @run_object_identifer_sibling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /run_object_identifer_siblings/1
  # PATCH/PUT /run_object_identifer_siblings/1.json
  def update
    respond_to do |format|
      if @run_object_identifer_sibling.update(run_object_identifer_sibling_params)
        format.html { redirect_to @run_object_identifer_sibling, notice: 'Run object identifer sibling was successfully updated.' }
        format.json { render :show, status: :ok, location: @run_object_identifer_sibling }
      else
        format.html { render :edit }
        format.json { render json: @run_object_identifer_sibling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /run_object_identifer_siblings/1
  # DELETE /run_object_identifer_siblings/1.json
  def destroy
    @run_object_identifer_sibling.destroy
    respond_to do |format|
      format.html { redirect_to run_object_identifer_siblings_url, notice: 'Run object identifer sibling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run_object_identifer_sibling
      @run_object_identifer_sibling = RunObjectIdentifierSibling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_object_identifer_sibling_params
      params.require(:run_object_identifer_sibling).permit(:identifier, :id_type, :selector, :run_object_identifer_id, :sibling_relationship_id)
    end
end
