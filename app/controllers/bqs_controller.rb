class BqsController < ApplicationController
  before_action :set_bq, only: [:show, :edit, :update, :destroy]

  def index
    @bqs = Bq.page params[:page]
  end

  def show
  end

  # GET /bqs/new
  def new
    @bq = Bq.new
  end

  # GET /bqs/1/edit
  def edit
  end

  # POST /bqs
  # POST /bqs.json
  def create
    @bq = Bq.new(bq_params)

    respond_to do |format|
      if @bq.save
        format.html { redirect_to @bq, notice: 'Bq was successfully created.' }
        format.json { render :show, status: :created, location: @bq }
      else
        format.html { render :new }
        format.json { render json: @bq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bqs/1
  # PATCH/PUT /bqs/1.json
  def update
    respond_to do |format|
      if @bq.update(bq_params)
        format.html { redirect_to @bq, notice: 'Bq was successfully updated.' }
        format.json { render :show, status: :ok, location: @bq }
      else
        format.html { render :edit }
        format.json { render json: @bq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bqs/1
  # DELETE /bqs/1.json
  def destroy
    @bq.destroy
    respond_to do |format|
      format.html { redirect_to bqs_url, notice: 'Bq was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render js: 'window.location.reload()' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bq
      @bq = Bq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bq_params
      params[:bq]
    end
end
