class Admin::SiteCategoriesController < Admin::MainController
  before_action :set_admin_site_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/site_categories
  # GET /admin/site_categories.json
  def index
    @admin_site_categories = SiteCategory.all
  end

  # GET /admin/site_categories/1
  # GET /admin/site_categories/1.json
  def show
  end

  # GET /admin/site_categories/new
  def new
    @admin_site_category = SiteCategory.new
  end

  # GET /admin/site_categories/1/edit
  def edit
  end

  # POST /admin/site_categories
  # POST /admin/site_categories.json
  def create
    @admin_site_category = SiteCategory.new(admin_site_category_params)

    respond_to do |format|
      if @admin_site_category.save
        format.html { redirect_to admin_site_categories_path, notice: 'Site category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_site_category }
      else
        format.html { render :new }
        format.json { render json: @admin_site_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/site_categories/1
  # PATCH/PUT /admin/site_categories/1.json
  def update
    respond_to do |format|
      if @admin_site_category.update(admin_site_category_params)
        format.html { redirect_to admin_site_categories_path, notice: 'Site category was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_site_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_site_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/site_categories/1
  # DELETE /admin/site_categories/1.json
  def destroy
    @admin_site_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_site_categories_url, notice: 'Site category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_site_category
      @admin_site_category = SiteCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_site_category_params
      params[:site_category].permit(:name)
    end
end
