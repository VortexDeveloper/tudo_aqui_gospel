class AnnouncersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_announcer, only: [:edit, :show, :update]
  before_action except: [:show, :new, :create] do
    authenticate_current_user(current_user.announcer != @announcer)
  end
  before_action :authenticate_admin, only: [:new, :create]

  def edit
    @announcer = Announcer.find(params[:id])
    @personal_profile = PersonalProfile.where("user_id = ?", @announcer.user_id).first
    @gallery = Gallery.new
  end

  def show
    @announcer = Announcer.find(params[:id])
    @personal_profile = PersonalProfile.where("user_id = ?", @announcer.user_id).first
  end

  def add_photo
    announcer = current_user.announcer
    announcer.photos << Gallery.new(gallery_params)
    announcer.save!
    redirect_to edit_announcer_path(announcer), notice: 'Foto adicionada a sua galeria com sucesso.'
  end

  def add_evaluation
    announcer = Announcer.where(id: evaluation_params[:announcer_id]).first
    evaluation = Evaluation.new(evaluation_params)
    evaluation.save!
    redirect_to announcer, notice: 'Avaliação adicionada com sucesso.'
  end

  def update
    respond_to do |format|
      if @announcer.update(announcer_params)
        update_main_phone
        format.html { redirect_to @announcer, notice: 'Cadastro atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @announcer }
      else
        format.html { render :edit }
        format.json { render json: @announcer.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @user = User.new
    @personal_profile = PersonalProfile.new
    @announcer = Announcer.new
    @telephone = Telephone.new
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.set_roles(params[:roles])
      @user.profile.update personal_profile_params
      @announcer = @user.announcer
      @announcer.update announcer_params
      respond_to do |format|
        format.html { redirect_to announcer_path(id: @announcer.id), notice: 'Anunciante cadastrado com sucesso!' }
      end
    else
        respond_to do |format|
            messages = []
            @user.errors.full_messages.each { |msg| messages << "<li>#{msg}</li>" }
            flash[:new_user_errors] = messages.join
            session[:user_error] = @user
            session[:profile_error] = personal_profile_params
            session[:announcer_error] = announcer_params
          format.html { redirect_to new_announcer_path }
        end
    end

  end

  def update_main_phone
    main_phone = @announcer.main_telephone

    if main_phone.id != main_phone_params[:phone_id].to_i
      main_phone.not_main!
      phone = Telephone.find main_phone_params[:phone_id]
      phone.main!
    end
  end

  def ad_params
    params.require(:ad).permit(
    :active
    )
  end

  def gallery_params
    params.require(:gallery).permit(
    :image
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
    :complement,
    :neighborhood,
    :city_id,
    :state_id,
    :country_id,
    :zip_code
    )
  end

  def evaluation_params
    params.require(:evaluation).permit(
    :comment,
    :user_id,
    :announcer_id
    )
  end

  def announcer_params
    params.require(:announcer).permit(
    :name,
    :fantasy_name,
    :contact_name,
    :doc_type,
    :doc,
    :email,
    :avatar,
    :photos,
    :ad_plan_id,
    :banner,
    :about_text,
    :state,
    :city
    )
  end

  def main_phone_params
    params.require(:main_phone).permit(
    :phone_id
    )
  end

  def load_announcer
    @announcer = Announcer.find params[:id]
  end
end
