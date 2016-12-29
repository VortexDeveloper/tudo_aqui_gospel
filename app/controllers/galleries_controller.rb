class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
  end

  # GET /galleries/1/edit
  def edit
  end


  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    announcer = Announcer.where("user_id = ?", current_user.id).first
    @gallery.destroy
    respond_to do |format|
      format.js { head :ok, notice: 'Foto excluída com sucesso.' }
      format.html { redirect_to edit_announcer_path(announcer), notice: 'Foto excluída com sucesso.' }
    end
  end

  def create
    @gallery = Gallery.new(gallery_params)

    respond_to do |format|
      if @gallery.save
        format.js { head :ok, notice: 'Foto adicionada a sua galeria com sucesso.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(
      :image,
      :announcer_id
      )
    end
end
