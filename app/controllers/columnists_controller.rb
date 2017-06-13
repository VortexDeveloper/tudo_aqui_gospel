class ColumnistsController < ApplicationController
  before_action only: [:edit, :update] do
    authenticate_current_user(user_signed_in? && current_user.columnist.nil?)
  end
  # before_action :is_active?, only: [:show]
  #
  # def is_active?
  #   redirect_to root_path, notice: 'Conteúdo não autorizado você precisa assinar nosso portal para acessar essa area!' unless current_user.active?
  # end

  def index
    @columnists = Columnist.all
  end

  def show
    @columnist = Columnist.find(params[:id])
    @publications_show = Publication.where(author_id: @columnist.user_id).paginate(page: params[:page], per_page: 4)
    @lastest_news = Publication.latest_news
  end

  def edit
    @columnist = current_user.columnist
  end

  def update
      @columnist = current_user.columnist
      if @columnist.update(columnist_params)
        redirect_to columnists_edit_url, notice: 'Dados atualizados com sucesso.'
      else
        render :edit
      end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.set_roles(params[:roles])
      @user.profile.update personal_profile_params
      @columnist = @user.columnist
      @columnist.update columnist_params
      sign_in(@user, scope: :user) unless user_signed_in?
      respond_to do |format|
        format.html {
          redirect_to root_path, notice: 'Cadastrado finalizado com sucesso'
        }
      end
    else
        respond_to do |format|
            messages = []
            @user.errors.full_messages.each { |msg| messages << "<li>#{msg}</li>" }
            flash[:new_user_errors] = messages.join
            session[:user_error] = @user
            session[:profile_error] = personal_profile_params
            session[:columnist_error] = columnist_params
          format.html { redirect_to new_columnist_path }
        end
    end
  end

  def columnist_params
    params.require(:columnist).permit(
    :periodicity,
    :admin_info,
    :birth_date,
    :sex,
    :admin_validate,
    :avatar
    )
  end

  def user_params
    params.require(:user).permit(
    :email,
    :password,
    :password_confirmation,
    :active
    )
  end

  def personal_profile_params
    params.require(:personal_profile).permit(
    :name,
    :street,
    :street_number,
    :complement,
    :neighborhood,
    :city_id,
    :state_id,
    :country_id,
    :zip_code,
    :cpf
    )
  end

end
