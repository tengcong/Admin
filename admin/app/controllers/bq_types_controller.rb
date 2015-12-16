class BqTypesController < ApplicationController
  before_action :set_bq_type, only: [:show, :edit, :update, :destroy]

  # GET /bq_types
  # GET /bq_types.json
  def index
    @bq_types = BqType.all
  end

  # GET /bq_types/1
  # GET /bq_types/1.json
  def show
  end

  # GET /bq_types/new
  def new
    @bq_type = BqType.new
  end

  # GET /bq_types/1/edit
  def edit
  end

  # POST /bq_types
  # POST /bq_types.json
  def create
    @bq_type = BqType.new(bq_type_params)

    respond_to do |format|
      if @bq_type.save
        format.html { redirect_to @bq_type, notice: 'Bq type was successfully created.' }
        format.json { render :show, status: :created, location: @bq_type }
      else
        format.html { render :new }
        format.json { render json: @bq_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bq_types/1
  # PATCH/PUT /bq_types/1.json
  def update
    respond_to do |format|
      if @bq_type.update(bq_type_params)
        format.html { redirect_to @bq_type, notice: 'Bq type was successfully updated.' }
        format.json { render :show, status: :ok, location: @bq_type }
      else
        format.html { render :edit }
        format.json { render json: @bq_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bq_types/1
  # DELETE /bq_types/1.json
  def destroy
    @bq_type.destroy
    respond_to do |format|
      format.html { redirect_to bq_types_url, notice: 'Bq type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bq_type
      @bq_type = BqType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bq_type_params
      params[:bq_type]
    end
end
