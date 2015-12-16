class BqPackagesController < ApplicationController
  before_action :set_bq_package, only: [:show, :edit, :update, :destroy]

  # GET /bq_packages
  # GET /bq_packages.json
  def index
    @bq_packages = BqPackage.page params[:page]
  end

  # GET /bq_packages/1
  # GET /bq_packages/1.json
  def show
    @bqs = @bq_package.bqs.page params[:page]
  end

  # GET /bq_packages/new
  def new
    @bq_package = BqPackage.new
  end

  # GET /bq_packages/1/edit
  def edit
  end

  # POST /bq_packages
  # POST /bq_packages.json
  def create
    @bq_package = BqPackage.new(bq_package_params)

    respond_to do |format|
      if @bq_package.save
        format.html { redirect_to @bq_package, notice: 'Bq package was successfully created.' }
        format.json { render :show, status: :created, location: @bq_package }
      else
        format.html { render :new }
        format.json { render json: @bq_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bq_packages/1
  # PATCH/PUT /bq_packages/1.json
  def update
    respond_to do |format|
      if @bq_package.update(bq_package_params)
        format.html { redirect_to @bq_package, notice: 'Bq package was successfully updated.' }
        format.json { render :show, status: :ok, location: @bq_package }
      else
        format.html { render :edit }
        format.json { render json: @bq_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bq_packages/1
  # DELETE /bq_packages/1.json
  def destroy
    @bq_package.destroy
    respond_to do |format|
      format.html { redirect_to bq_packages_url, notice: 'Bq package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bq_package
      @bq_package = BqPackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bq_package_params
      params[:bq_package]
    end
end
