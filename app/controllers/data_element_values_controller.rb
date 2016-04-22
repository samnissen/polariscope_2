class DataElementValuesController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_data_element_value, only: [:show, :edit, :update, :destroy]
  before_action :set_collections, only: [:new, :create, :edit, :update, :destroy]
  before_filter :belongs_to_user, only: [:edit, :update, :destroy]
  before_action :reset_errors

  # GET /data_element_values
  # GET /data_element_values.json
  def index
    @data_element_values = DataElementValue.where(user: current_user)
  end

  # GET /data_element_values/1
  # GET /data_element_values/1.json
  def show
  end

  # GET /data_element_values/new
  def new
    @data_element_value = DataElementValue.new(:data_element_id => params[:data_element_id])
  end

  # GET /data_element_values/1/edit
  def edit
  end

  # POST /data_element_values
  # POST /data_element_values.json
  def create
    @data_element_value = DataElementValue.new(data_element_params)
    @data_element_value.user = current_user

    respond_to do |format|
      if @data_element_value.save
        format.html { redirect_to data_elements_path, notice: 'Data element was successfully created.' }
        format.json { render :show, status: :created, location: @data_element_value }
      else
        prepare_errors
        format.html { render :new }
        format.json { render json: @data_element_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_element_values/1
  # PATCH/PUT /data_element_values/1.json
  def update
    respond_to do |format|
      if @data_element_value.update(data_element_params)
        format.html { redirect_to data_elements_path, notice: 'Data element was successfully updated.' }
        format.json { render :show, status: :ok, location: @data_element_value }
      else
        prepare_errors
        format.html { render :edit }
        format.json { render json: @data_element_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_element_values/1
  # DELETE /data_element_values/1.json
  def destroy
    @data_element_value.destroy
    respond_to do |format|
      format.html { redirect_to data_elements_path, notice: 'Data element was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_element_value
      @data_element_value = DataElementValue.find(params[:id])
    end

    def set_collections
      @environments = Environment.where(user: current_user).order('name ASC')
      @variables = DataElement.where(user: current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_element_params
      params.require(:data_element_value).permit(:value, :environment_id, :user_id, :data_element_id, :random_value, :random_value_length)
    end

    def prepare_errors
      nil unless @data_element_value && Array(@data_element_value.errors).size > 0

      flash[:error] ||= []

      @data_element_value.errors.to_a.each do |err|
        flash[:error] << "#{err}"
      end
    end

    def reset_errors
      flash[:error] = []
    end

    def belongs_to_user
      return true if (@data_element_value.user == current_user)

      @data_element_value.errors.add(:base, 'You must be the owner to perform that action')
      prepare_errors
      redirect_to data_element_values_path and return
    end
end
