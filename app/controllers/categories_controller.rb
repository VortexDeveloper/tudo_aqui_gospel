class CategoriesController < ApplicationController
  before_action :set_category
  # before_action :is_active?, only: [:show]
  #
  # def is_active?
  #   if user_signed_in?
  #     redirect_to root_path, notice: 'Conteúdo não autorizado você precisa assinar nosso portal para acessar essa area!' unless current_user.active?
  #   else
  #     redirect_to root_path, notice: 'Conteúdo não autorizado você precisa assinar nosso portal para acessar essa area!'
  #   end
  # end

  def show
    @ads = Ad.where(category_id: params[:id]).includes(:category)
  end

  def search
    @ads = Ad.joins(announcer: [user: :profile])
    .where("lower(text_description) LIKE ? OR lower(title) LIKE ?", "%#{params[:query]}%".downcase, "%#{params[:query]}%".downcase)
    .where(category_id: params[:id])
    if params[:personal_profile_state_id].present?
      @ads = @ads.where(personal_profiles: {state_id: params[:personal_profile_state_id]})
      if params[:personal_profile][:city_id].present?
        @ads = @ads.where(personal_profiles: {city_id: params[:personal_profile][:city_id]})
      end
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render :show, status: :ok, location: @ad }
    end
  end

  def set_category
    @category = Category.find params[:id]
  end
end
