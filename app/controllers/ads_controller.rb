class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]
  before_action only: [:update] do
    authenticate_current_user(current_user.announcer != @ad.announcer)
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    announcer = current_user.announcer
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to edit_announcer_path(announcer), notice: 'Anuncio atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(
      :description,
      :title,
      :link,
      :text_description,
      :avatar,
      :start_date,
      :end_date,
      :price,
      :active
      )
    end
end
