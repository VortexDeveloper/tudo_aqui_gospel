module ApplicationHelper
  def resource_name
    :user
  end

  def show_notices(notice)
    if notice.present?
      render partial: 'layouts/shareds/notices'
    end
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
      render partial: "layouts/application/profile"
    else
      render partial: "layouts/application/login"
    end
  end

  def add_post_button
    if user_signed_in?
      columnist = current_user.roles.where("name = ?", "Columnist")
      if columnist.present?
        link_to "NOVO POST", "#", class: 'rst-accsetting-addpost rst-addpost-mobile'
      end
    end
  end

  def plus_post_button
    if user_signed_in?
      columnist = current_user.roles.where("name = ?", "Columnist")
      if columnist.present?
        link_to "#", class: 'rst-accsetting-addpost' do
          content_tag(:i, "", :class => 'fa fa-plus')
        end
      end
    end
  end

  def cities_for_select
    options_from_collection_for_select(City.all, 'id', 'name', 1)
  end

  def states_for_select
    options_from_collection_for_select(State.all, 'id', 'name', 1)
  end

end
