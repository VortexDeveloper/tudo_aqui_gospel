class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions

  def index

  end

  def after_sign_up_path_for(user)
    if user.has_any_role? "Administrator", "Announcer", "Columnist", "Insider"
      rails_admin_edit_path(PersonalProfile, user)
    else
      root_path
    end
  end
end
