class Admin::AlbumsController < Admin::MainController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  include Publishable
  include BasicControl

  ######### API #########
  def tags
    respond_to do |format|
      format.html
      format.json { render json: {data: Album.published.tag_list } }
    end
  end

  def tagged_with
    @albums = Album.published.ordered.tagged_with(params[:tag]).page(params[:page])
    render 'albums.json.jbuilder'
  end
  ######### API #########

  def index
    @albums = Album.ordered.page params[:page]

    if tag = params[:tag]
      @albums = @albums.tagged_with tag
    end
  end

  def show
    @photos = @album.photos.page params[:page]

    if request.format == 'application/json'
      impressionist(@album, "viewed")
    end
  end

  def new
    @album = Album.new
  end

  def edit
  end

  def create
    @album = Album.new(album_params)

    respond_to do |format|
      if @album.save
        format.html { redirect_to [:admin, @album], notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to [:admin, @album], notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to admin_albums_path, notice: 'Bq package was successfully destroyed.', turbolinks: true }
      format.json { head :no_content }
      format.js { render js: "window.location.reload()" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params[:album].permit(:title, tags: [])
    end
end
