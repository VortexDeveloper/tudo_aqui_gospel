RailsAdmin.config do |config|

  config.parent_controller = 'ApplicationController'

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true


  config.excluded_models << 'Phonebook'
  config.excluded_models << 'AverageCache'
  config.excluded_models << 'OverallAverage'
  config.excluded_models << 'Rate'
  config.excluded_models << 'RatingCache'
  config.excluded_models << 'Telephone'
  config.excluded_models << 'ColumnistKnowledge'

  # config.model 'Box' do
  #   label "Beautiful box"
  #   label_plural "Beautiful boxen"
  # end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Announcer']
    end
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Publication do
    edit do
      # For RailsAdmin >= 0.5.0
      field :image
      field :title
      field :description
      field :body, :ck_editor
      field :pub_type
      field :pub_category
      field :knowledge_area
      field :pub_attachments
      field :author
      # For RailsAdmin < 0.5.0
      # field :description do
      #   ckeditor true
      # end
    end
  end

  config.model User do
    edit do
      # For RailsAdmin >= 0.5.0
      field :email
      field :password
      field :password_confirmation
      field :active
      field :roles
    end
  end

  config.model Ad do
    edit do
      field :title do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :description do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :text_description
      field :start_date do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :end_date do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :price do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :category do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :announcer do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :avatar do
        required true
        # html_attributes do
        #   {required: 'required'}
        # end
      end
      field :ad_type do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :home do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
      field :active do
        required true
        html_attributes do
          {required: 'required'}
        end
      end
    end
  end
end
