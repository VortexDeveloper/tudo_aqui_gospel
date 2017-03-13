module AnnouncersHelper
  def show_telephone
    html = content_tag(:i, '', class: "fa fa-lg fa-mobile")
    html << content_tag(:span, @announcer.user_main_phone.number)
  end

  def show_email
    html = content_tag(:i, '', class: "fa fa-lg fa-envelope")
    html << content_tag(:span, @announcer.email)
  end

  def show_edit_email(form_builder)
    html = content_tag(:i, '', class: "fa fa-lg fa-envelope")
    html << form_builder.text_field(:email, value: @announcer.email, class: 'rst-announcer-input')
  end

  def show_location
    html = content_tag(:i, '', class: "fa fa-lg fa-map-marker")
    html << content_tag(:span, @announcer.address_string)
  end

  def show_average
    html = content_tag(:i, '', class: "fa fa-lg fa-star", style: 'color: #EDA100;')
    html << content_tag(:span, @announcer.average('quality').avg)
  end

  def select_for_telephones(form_builder)
    telephones = @announcer.user_telephones
    main_phone = @announcer.user_main_phone
    if telephones.present?
      select(
        :main_phone,
        :phone_id,
        telephones.collect {|t| [ t.number, t.id ] },
        {
          selected: main_phone.id
        },
        class: 'rst-pageinput',
        style: 'float: left; width: auto; margin-right: 10px;'
      )
    else
      content_tag :span, "Não há telefones cadastrados"
    end
  end
end
