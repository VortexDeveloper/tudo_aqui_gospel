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

  def curriculum_button
    if user_signed_in?
      subscriber = current_user.roles.where(name: "Subscriber")
      if subscriber.present?
        if current_user.subscriber.curriculum.present?
          content_tag(:li, "") do
            link_to "Editar Currículo", edit_curriculum_path(@curriculum)
          end
        else
          content_tag(:li, "") do
            link_to "Cadastrar Currículo", new_curriculum_path
          end
        end
      end
    end
  end

  def publications_button
    if user_signed_in?
      columnist = current_user.roles.where(name: "Columnist")
      if columnist.present?
        if current_user.publications.first.present?
          content_tag(:li, "") do
            link_to "Minhas publicações", publications_path
          end
        else
          content_tag(:li, "") do
            link_to "Criar publicação", new_publication_path
          end
        end
      end
    end
  end

  def plus_post_button
    if user_signed_in?
      columnist = current_user.roles.where("name = ?", "Columnist")
      if columnist.present?
        link_to new_publication_path, class: 'rst-accsetting-addpost' do
          content_tag(:i, "", :class => 'fa fa-plus')
        end
      end
    end
  end

  def show_profile_type
    if user_signed_in?
      profile_type = current_user.roles.first.name

      case profile_type
        when "Columnist"
          content_tag(:li, "") do
            link_to "Dados do Perfil", columnists_edit_path
          end
        when "Subscriber"
          content_tag(:li, "") do
            link_to "Dados do Perfil", subscribers_edit_path
          end
        when "Administrator"
          content_tag(:li, "") do
            link_to "Cadastro de anunciante", new_announcer_path
          end
        when "Announcer"
          content_tag(:li, "") do
            link_to "Dados da Página", edit_announcer_path(@announcer)
          end
      end
    end
  end

  def show_admin
    if user_signed_in?
      profile_type = current_user.roles.first.name

      if profile_type == "Administrator"
        content_tag(:li, "") do
          link_to "Painel de administração", rails_admin_path
        end
      end
    end
  end

  def show_image_thumb(columnist, subscriber, announcer)
    if user_signed_in?
      profile_type = current_user.roles.first.name
      case profile_type
        when "Columnist"
          if columnist.avatar.present?
            image_tag columnist.avatar.url(:thumb)
          else
            image_tag ('user_thumb.png')
          end
        when "Subscriber"
          if subscriber.avatar.present?
            image_tag subscriber.avatar.url(:thumb)
          else
            image_tag ('user_thumb.png')
          end
        when "Announcer"
          if announcer.avatar.present?
            image_tag announcer.avatar.url(:thumb)
          else
            image_tag ('user_thumb.png')
          end
      end
    end
  end

  def plans_for_select(selected)
    selected ||= 1
    options_from_collection_for_select(AdPlan.all, 'id', 'name', selected)
  end

  def cities_for_select
    options_from_collection_for_select(City.all, 'id', 'name', 1)
  end

  def states_for_select
    options_from_collection_for_select(State.all, 'id', 'name', 1)
  end

  def knowledge_area_for_select(selected=nil)
    selected = selected || 1
    options_from_collection_for_select(KnowledgeArea.all, 'id', 'name', selected)
  end

  def city_show(id)
    if id.present?
      City.find(id).name
    end
  end

  def state_show(id)
    if id.present?
      State.find(id).uf
    end
  end

  def media_section_banner(announcer)
    if announcer.ad_plan.silver? || announcer.ad_plan.gold?
      render partial: 'announcers/show/media_section_banner'
    end
  end

  def media_section_gallery(announcer)
    if announcer.ad_plan.gold?
      render partial: 'announcers/show/media_section_gallery'
    end
  end

  def media_section_gallery_slide(announcer)
    if announcer.ad_plan.gold?
      render partial: 'announcers/show/media_section_gallery_slide'
    end
  end

  def media_section_banner_edit(announcer)
    if announcer.ad_plan.silver? || announcer.ad_plan.gold?
      render partial: 'announcers/edit/media_section_banner'
    end
  end

  def media_section_gallery_edit(announcer)
    if announcer.ad_plan.silver? || announcer.ad_plan.gold?
      render partial: 'announcers/edit/media_section_gallery'
    end
  end

  def media_section_gallery_slide_edit(announcer)
    if announcer.ad_plan.silver? || announcer.ad_plan.gold?
      render partial: 'announcers/edit/media_section_gallery_slide'
    end
  end

  def add_photo_button(announcer)
    if announcer.ad_plan.silver?
      if announcer.photos.count < 10
        render partial: 'announcers/edit/add_photo_button'
      end
    end
    if announcer.ad_plan.gold?
        if announcer.photos.count < 20
          render partial: 'announcers/edit/add_photo_button'
        end
    end
  end

end
