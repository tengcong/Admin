class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  include Publishable
  include BasicControl

  ######### API #########
  def tags
    render json: { data: Album.published.tag_list }
  end

  def hot
    @albums = Album.published.ordered.tagged_with('热门').limit(30)
    render 'albums.json.jbuilder'
  end

  def tagged_with
    @albums = Album.published.ordered.tagged_with(params[:tag])
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
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
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
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
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
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params[:album]
    end
end
