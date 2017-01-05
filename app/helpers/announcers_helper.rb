module AnnouncersHelper
    def show_telephone
        html = content_tag(:i, '', class: "fa fa-lg fa-mobile")
        html << content_tag(:span, @announcer.main_telephone.number)
    end

    def show_email
        html = content_tag(:i, '', class: "fa fa-lg fa-paper-plane")
        html << content_tag(:span, @announcer.email)
    end

    def show_location
        html = content_tag(:i, '', class: "fa fa-lg fa-map-marker")
        html << content_tag(:span, @announcer.address_string)
    end

    def show_average
        html = content_tag(:i, '', class: "fa fa-lg fa-star", style: 'color: #EDA100;')
        html << content_tag(:span, @announcer.average('quality').avg)
    end
end
