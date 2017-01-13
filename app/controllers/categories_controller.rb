class CategoriesController < ApplicationController
  before_action :set_category

  def show
    @ads = Ad.where(category_id: params[:id]).includes(:category)
  end

  def search
    @ads = Ad.joins(announcer: [user: :profile])
    .where("text_description LIKE :query", query: "%#{params[:query]}%")
    .where(category_id: params[:id])
    @ads = @ads.where(personal_profiles: {city_id: params[:personal_profile][:city_id]}) if params[:personal_profile][:city_id].present?
    @ads = @ads.where(personal_profiles: {state_id: params[:personal_profile_state_id]}) if params[:personal_profile_state_id].present?

    respond_to do |format|
      format.html { render :show }
      format.json { render :show, status: :ok, location: @ad }
    end
  end

  def set_category
    @category = Category.find params[:id]
  end
end
