class Admin::CrawlingEndpointsController < Admin::MainController
  before_action :set_admin_crawling_endpoint, only: [:show, :edit, :update, :destroy]

  def crawl_list
    endpoint = CrawlingEndpoint.find(params[:crawling_endpoint_id])
    @articles = endpoint.crawl
  end

  # GET /admin/crawling_endpoints
  # GET /admin/crawling_endpoints.json
  def index
    @admin_crawling_endpoints = CrawlingEndpoint.all
  end

  # GET /admin/crawling_endpoints/1
  # GET /admin/crawling_endpoints/1.json
  def show
  end

  # GET /admin/crawling_endpoints/new
  def new
    @admin_crawling_endpoint = CrawlingEndpoint.new
  end

  # GET /admin/crawling_endpoints/1/edit
  def edit
  end

  # POST /admin/crawling_endpoints
  # POST /admin/crawling_endpoints.json
  def create
    @admin_crawling_endpoint = CrawlingEndpoint.new(admin_crawling_endpoint_params)

    respond_to do |format|
      if @admin_crawling_endpoint.save
        format.html { redirect_to admin_crawling_endpoints_path, notice: 'Crawling endpoint was successfully created.' }
        format.json { render :show, status: :created, location: @admin_crawling_endpoint }
      else
        format.html { render :new }
        format.json { render json: @admin_crawling_endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/crawling_endpoints/1
  # PATCH/PUT /admin/crawling_endpoints/1.json
  def update
    respond_to do |format|
      if @admin_crawling_endpoint.update(admin_crawling_endpoint_params)
        format.html { redirect_to admin_crawling_endpoints_path, notice: 'Crawling endpoint was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_crawling_endpoint }
      else
        format.html { render :edit }
        format.json { render json: @admin_crawling_endpoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/crawling_endpoints/1
  # DELETE /admin/crawling_endpoints/1.json
  def destroy
    @admin_crawling_endpoint.destroy
    respond_to do |format|
      format.html { redirect_to admin_crawling_endpoints_url, notice: 'Crawling endpoint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_crawling_endpoint
      @admin_crawling_endpoint = CrawlingEndpoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_crawling_endpoint_params
      params[:crawling_endpoint].permit(:url,
        :list_item_selector, :thumbnail_selector, :title_selector, :description_selector, :published_at_selector, :detail_page_selector)
    end
end
