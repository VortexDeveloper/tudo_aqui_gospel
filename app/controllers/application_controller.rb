class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :global_variables
  include CanCan::ControllerAdditions

  def global_variables
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
      @announcer = Announcer.where("user_id = ?", current_user.id).first
      @personal_profile = PersonalProfile.where("user_id = ?", current_user.id).first
    end
    @versicles = Versicle.where("show_day = ?", Date.today)
    @categories = Category.all
    @vacancies = Vacancy.all.shuffle

    #Ads side
    @ads_min = Ad.all.shuffle.first(4)
    @ads_med = Ad.all.shuffle.first(6)
    @ads_max = Ad.all.shuffle.first(8)
    #Ads home
    @banner_home = Ad.where(active: "sim").where(ad_type: "banner").where(home: "s").shuffle
    @principal_home = Ad.where(active: "sim").where(ad_type: "principal").where(home: "s").shuffle.first(2)
    @normal_home =Ad.where(active: "sim").where(ad_type: "normal").where(home: "s").shuffle.first(10)
    #Ads pages
    @banner = Ad.where(active: "sim").where(ad_type: "banner").shuffle
    @principal = Ad.where(active: "sim").where(ad_type: "principal").shuffle.first(2)
    @normal =Ad.where(active: "sim").where(ad_type: "normal").shuffle.first(10)

  end

  def after_sign_in_path_for(user)
    if user.has_any_role? "Administrator", "Announcer", "Columnist", "Insider"
      personal_profiles_edit_path
    else
      root_path
    end
  end

  def ads_categories
    @page_title = Category.find(params[:id_category]).name
    @ads_categories = Ad.where("category_id LIKE ?", params[:id_category])
  end

end
