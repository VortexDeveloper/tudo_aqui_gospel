class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :global_variables
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :notice => exception.message }
    end
  end

  def global_variables
    if user_signed_in?
      @columnist = current_user.columnist
      @subscriber = current_user.subscriber
      @announcer = current_user.announcer
      @administrator =  current_user.administrator
      @personal_profile = current_user.profile
      @curriculum = @subscriber.try(:curriculum)
    end

    @versicles = Versicle.all.order(created_at: :desc)
    @categories = Category.all
    @vacancies = Vacancy.all.shuffle
    @curriculums = Curriculum.all.shuffle

    #Publications
    @last_publications = Publication.latest_publications.first(4)
    @publications_category = Publication.where(pub_category: Publication.random_category, pub_type: "post")
    @news = Publication.where(pub_type: "news")

    #Ads side
    @ads_min = Ad.active.shuffle.first(4)
    @ads_med = Ad.active.shuffle.first(6)
    @ads_max = Ad.active.shuffle.first(8)

    #Ads pages
    @principal = Ad.active_side_banner(home: false).first(2)
    @banner = Ad.active_banner(home: false).first(5)
    @normal =Ad.active_normal(home: false).first(10)
  end

  def after_sign_in_path_for(user)
    if user.has_any_role? "Administrator", "Announcer", "Columnist", "Insider"
      personal_profiles_edit_path
    else
      root_path
    end
  end

  def authenticate_admin
    authenticate_user!
    unless(current_user.has_role?(:administrator) or current_user.has_role?(:insider))
      redirect_to after_sign_in_path_for(current_user), notice: 'Você não está autorizado a acessar esta página.'
    end
  end

  def authenticate_current_user(_condition)
    authenticate_user!
    redirect_to after_sign_in_path_for(current_user), notice: 'Você não está autorizado a acessar esta página.' if _condition
  end
end
