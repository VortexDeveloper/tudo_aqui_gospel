module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def session_button
    if user_signed_in?
      link_to "Sair", destroy_user_session_path, method: :delete, class: 'btn news_button logout-btn'
    else
      render partial: "application/login"
    end
  end
end
