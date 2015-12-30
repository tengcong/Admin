class BqPackagesController < ApplicationController

  include Publishable
  include BasicControl

  before_action :set_bq_package, only: [:show, :edit, :update, :destroy]

  def tags
    respond_to do |format|
      format.html
      format.json { render json: {data: BqPackage.published.tag_list } }
    end
  end

  def tagged_with
    @bq_packages = BqPackage.published.ordered.tagged_with(params[:tag]).page(params[:page])
    render 'bq_packages.json.jbuilder'
  end

  def index
    @bq_packages = BqPackage.order(position: :asc).page(params[:page])

    if tag = params[:tag]
      @bq_packages = @bq_packages.tagged_with tag
    end
  end

  def show
    @bqs = @bq_package.bqs.page params[:page]
  end

  def new
    @bq_package = BqPackage.new
  end

  def edit
  end

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

  def destroy
    @bq_package.destroy
    respond_to do |format|
      format.html { redirect_to bq_packages_path, notice: 'Bq package was successfully destroyed.', turbolinks: true }
      format.json { head :no_content }
      format.js { render js: "window.location.reload()" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bq_package
      @bq_package = BqPackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bq_package_params
      params[:bq_package].permit(:name, tags: [])
    end
end
