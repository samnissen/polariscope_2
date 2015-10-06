class DataElementsController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_data_element, only: [:show, :edit, :update, :destroy]
  before_filter :belongs_to_user, only: [:edit, :update, :destroy]
  before_action :reset_errors

  # GET /data_elements
  # GET /data_elements.json
  def index
    @data_elements = DataElement.where(user: current_user)
  end

  # GET /data_elements/1
  # GET /data_elements/1.json
  # def show
  # end

  # GET /data_elements/new
  def new
    @data_element = DataElement.new
  end

  # GET /data_elements/1/edit
  def edit
  end

  # POST /data_elements
  # POST /data_elements.json
  def create
    @data_element = DataElement.new(data_element_params)
    @data_element.user = current_user

    respond_to do |format|
      if @data_element.save
        format.html { redirect_to data_elements_path, notice: 'Data element was successfully created.' }
        format.json { render :show, status: :created, location: @data_element }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @data_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_elements/1
  # PATCH/PUT /data_elements/1.json
  def update
    respond_to do |format|
      if @data_element.update(data_element_params)
        format.html { redirect_to data_elements_path, notice: 'Data element was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_element }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @data_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_elements/1
  # DELETE /data_elements/1.json
  def destroy
    @data_element.destroy
    respond_to do |format|
      format.html { redirect_to data_elements_path, notice: 'Data element was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_element
      @data_element = DataElement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_element_params
      params.require(:data_element).permit(:key, :environment_id, :user_id)
    end

    def prepare_errors
      nil unless @data_element && Array(@data_element.errors).size > 0

      flash[:error] ||= []

      @data_element.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def belongs_to_user
      return true if (@data_element.user == current_user)

      @data_element.errors.add(:base, 'You must be the owner to perform that action')
      prepare_errors
      redirect_to data_elements_path and return
    end
end
