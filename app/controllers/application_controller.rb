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

    @ads_ban = Ad.all.order('created_at DESC limit 2').shuffle
    @ads_body = Ad.all.order('created_at DESC limit 10').shuffle
    @ads = Ad.all.shuffle
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
