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
      if current_user.has_any_role? 'Columnist', 'Administrator'
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
      if current_user.has_any_role? 'Columnist', 'Administrator'
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
            link_to "Dados do Colunista", columnists_edit_path
          end
        when "Subscriber"
          content_tag(:li, "") do
            link_to "Dados do Assinante", subscribers_edit_path
          end
        when "Administrator"
          content_tag(:li, "") do
            link_to "Cadastro de anunciante", new_announcer_path
          end
        when "Announcer"
          content_tag(:li, "") do
            link_to "Minha página", announcer_path(@announcer)
          end
      end
    end
  end

  def show_admin
    if user_signed_in?
      if current_user.has_role?(:administrator) || current_user.has_role?(:insider)
        content_tag(:li, "") do
          link_to "Painel de administração", rails_admin_path
        end
      end
    end
  end

  def show_image_thumb(columnist, subscriber, announcer, administrator)
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
        when "Administrator"
            image_tag ('user_thumb.png')
      end
    end
  end

  def plans_for_select(selected)
    selected ||= 1
    options_from_collection_for_select(AdPlan.all, 'id', 'name', selected)
  end

  def cities_for_select(selected=nil)
    selected = selected || 1
    options_from_collection_for_select(City.all, 'id', 'name', selected)
  end

  def states_for_select(selected=nil)
    selected = selected || 1
    options_from_collection_for_select(State.all, 'id', 'name', selected)
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

  def media_section_banner_edit(announcer, form_builder)
    if announcer.ad_plan.silver? || announcer.ad_plan.gold?
      render partial: 'announcers/edit/media_section_banner', locals: {f: form_builder}
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

  def rating_for_user(rateable_obj, rating_user, dimension = nil, options = {})
    @object = rateable_obj
    @user   = rating_user
	  @rating = Rate.find_by_rater_id_and_rateable_id_and_dimension(@user.id, @object.id, dimension)
	  stars = @rating ? @rating.stars : 5

    star         = options[:star]         || 5
    enable_half  = options[:enable_half]  || false
    half_show    = options[:half_show]    || true
    star_path    = options[:star_path]    || ''
    star_on      = options[:star_on]      || image_path('star-on.png')
    star_off     = options[:star_off]     || image_path('star-off.png')
    star_half    = options[:star_half]    || image_path('star-half.png')
    cancel       = options[:cancel]       || false
    cancel_place = options[:cancel_place] || 'left'
    cancel_hint  = options[:cancel_hint]  || 'Cancel current rating!'
    cancel_on    = options[:cancel_on]    || image_path('cancel-on.png')
    cancel_off   = options[:cancel_off]   || image_path('cancel-off.png')
    noRatedMsg   = options[:noRatedMsg]   || 'I\'am readOnly and I haven\'t rated yet!'
    # round        = options[:round]        || { down: .26, full: .6, up: .76 }
    space        = options[:space]        || false
    single       = options[:single]       || false
    target       = options[:target]       || ''
    targetText   = options[:targetText]   || ''
    targetType   = options[:targetType]   || 'hint'
    targetFormat = options[:targetFormat] || '{score}'
    targetScore  = options[:targetScore]  || ''
    readOnly     = options[:readonly]     || false
    id           = options[:id]           || ''
    klass        = options[:class]        || ''

    disable_after_rate = options[:disable_after_rate] || false

    if disable_after_rate
      readOnly = rating_user.present? ? !rateable_obj.can_rate?(rating_user, dimension) : true
    end

    content_tag :div, '', "data-dimension" => dimension, :class => "star #{klass}", :id => id,
                "data-rating" => stars,
                "data-id" => rateable_obj.id,
                "data-classname" => rateable_obj.class.name == rateable_obj.class.base_class.name ? rateable_obj.class.name : rateable_obj.class.base_class.name,
                "data-disable-after-rate" => disable_after_rate,
                "data-readonly" => readOnly,
                "data-enable-half" => enable_half,
                "data-half-show" => half_show,
                "data-star-count" => star,
                "data-star-path" => star_path,
                "data-star-on" => star_on,
                "data-star-off" => star_off,
                "data-star-half" => star_half,
                "data-cancel" => cancel,
                "data-cancel-place" => cancel_place,
                "data-cancel-hint"  => cancel_hint,
                "data-cancel-on" => cancel_on,
                "data-cancel-off" => cancel_off,
                "data-no-rated-message" => noRatedMsg,
                # "data-round" => round,
                "data-space" => space,
                "data-single" => single,
                "data-target" => target,
                "data-target-text" => targetText,
                "data-target-format" => targetFormat,
                "data-target-score" => targetScore
  end
end
