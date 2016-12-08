class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CanCan::ControllerAdditions

  def index

  end

  def after_sign_in_path_for(user)
    if user.has_any_role? "Administrator", "Announcer", "Columnist", "Insider"
      personal_profiles_edit_path
    else
      root_path
    end
  end
end
