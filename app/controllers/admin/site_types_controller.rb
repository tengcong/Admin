class Admin::SiteTypesController < Admin::MainController
  before_action :set_admin_site_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/site_types
  # GET /admin/site_types.json
  def index
    @admin_site_types = SiteType.all
  end

  # GET /admin/site_types/1
  # GET /admin/site_types/1.json
  def show
  end

  # GET /admin/site_types/new
  def new
    @admin_site_type = SiteType.new
  end

  # GET /admin/site_types/1/edit
  def edit
  end

  # POST /admin/site_types
  # POST /admin/site_types.json
  def create
    @admin_site_type = SiteType.new(admin_site_type_params)

    respond_to do |format|
      if @admin_site_type.save
        format.html { redirect_to admin_site_types_path, notice: 'Site type was successfully created.' }
        format.json { render :show, status: :created, location: @admin_site_type }
      else
        format.html { render :new }
        format.json { render json: @admin_site_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/site_types/1
  # PATCH/PUT /admin/site_types/1.json
  def update
    respond_to do |format|
      if @admin_site_type.update(admin_site_type_params)
        format.html { redirect_to admin_site_types_path, notice: 'Site type was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_site_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_site_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/site_types/1
  # DELETE /admin/site_types/1.json
  def destroy
    @admin_site_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_site_types_url, notice: 'Site type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_site_type
      @admin_site_type = SiteType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_site_type_params
      params[:site_type].permit(:name, :site_category_id)
    end
end
