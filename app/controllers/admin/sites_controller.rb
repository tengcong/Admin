class Admin::SitesController < Admin::MainController
  before_action :set_admin_site, only: [:show, :edit, :update, :destroy]

  include BasicControl

  # GET /admin/sites
  # GET /admin/sites.json
  def index
    @admin_sites = Site.ordered.page params[:page]
  end

  # GET /admin/sites/1
  # GET /admin/sites/1.json
  def show
  end

  # GET /admin/sites/new
  def new
    @admin_site = Site.new
  end

  # GET /admin/sites/1/edit
  def edit
  end

  # POST /admin/sites
  # POST /admin/sites.json
  def create
    @admin_site = Site.new(admin_site_params)

    respond_to do |format|
      if @admin_site.save
        format.html { redirect_to admin_sites_path, notice: 'Site was successfully created.' }
        format.json { render :show, status: :created, location: @admin_site }
      else
        format.html { render :new }
        format.json { render json: @admin_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/sites/1
  # PATCH/PUT /admin/sites/1.json
  def update
    respond_to do |format|
      if @admin_site.update(admin_site_params)
        format.html { redirect_to admin_sites_path, notice: 'Site was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_site }
      else
        format.html { render :edit }
        format.json { render json: @admin_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sites/1
  # DELETE /admin/sites/1.json
  def destroy
    @admin_site.destroy
    respond_to do |format|
      format.html { redirect_to admin_sites_url, notice: 'Site was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render js: "window.location.reload()" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_site
      @admin_site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_site_params
      params[:site].permit(:title, :url, :icon_url, :site_type_id)
    end
end
