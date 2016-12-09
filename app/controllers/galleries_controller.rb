class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :destroy]
  skip_before_filter :verify_authenticity_token


  def show
  end

  def destroy
    announcer = Announcer.where("user_id = ?", current_user.id).first
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to edit_announcer_path(announcer), notice: 'Foto excluída com sucesso.' }
      format.json { head :no_content }
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
