class TestsetsController < ApplicationController
  before_action :set_testset, only: [:show, :edit, :update, :destroy]

  # GET /testsets
  # GET /testsets.json
  def index
    @testsets = Testset.all
  end

  # GET /testsets/1
  # GET /testsets/1.json
  def show
  end

  # GET /testsets/new
  def new
    @testset = Testset.new
  end

  # GET /testsets/1/edit
  def edit
  end

  # POST /testsets
  # POST /testsets.json
  def create
    @testset = Testset.new(testset_params)

    respond_to do |format|
      if @testset.save
        format.html { redirect_to @testset, notice: 'Testset was successfully created.' }
        format.json { render :show, status: :created, location: @testset }
      else
        format.html { render :new }
        format.json { render json: @testset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testsets/1
  # PATCH/PUT /testsets/1.json
  def update
    respond_to do |format|
      if @testset.update(testset_params)
        format.html { redirect_to @testset, notice: 'Testset was successfully updated.' }
        format.json { render :show, status: :ok, location: @testset }
      else
        format.html { render :edit }
        format.json { render json: @testset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testsets/1
  # DELETE /testsets/1.json
  def destroy
    @testset.destroy
    respond_to do |format|
      format.html { redirect_to testsets_url, notice: 'Testset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testset
      @testset = Testset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def testset_params
      params.require(:testset).permit(:name, :description, :collection_id, :user_id)
    end
end
