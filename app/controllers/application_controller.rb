class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :global_variables
  include CanCan::ControllerAdditions

  def global_variables
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
      @announcer = Announcer.where("user_id = ?", current_user.id).first
    end
    @versicles = Versicle.where("show_day = ?", Date.today)
    @ads_ban = Ad.all.order('created_at DESC limit 2').shuffle
    @ads_body = Ad.all.order('created_at DESC limit 10').shuffle
    @vacancies = Vacancy.all.shuffle
    @ads = Ad.all.shuffle
  end

  def after_sign_in_path_for(user)
    #PersonalProfile.create!(user: user)
    #user.set_roles(params[:roles])
    if user.has_any_role? "Administrator", "Announcer", "Columnist", "Insider"
      personal_profiles_edit_path
    else
      root_path
    end
  end

end
