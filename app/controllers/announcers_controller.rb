class AnnouncersController < ApplicationController

  def edit
  end

  def show
    @announcer = Announcer.find(params[:id])
    @personal_profile = PersonalProfile.where("user_id = ?", @announcer.user_id).first
  end

  def update
      @announcer = Announcer.where("user_id = ?", current_user.id).first
      if @announcer.update(announcer_params)
        redirect_to announcer_edit_url, notice: 'Dados atualizados com sucesso.'
      else
        render :edit
      end
  end

  def new
    @user = User.new
    @personal_profile = PersonalProfile.new
    @announcer = Announcer.new
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    end
  end

  def create
    @user = User.create!(user_params)
    @personal_profile = PersonalProfile.new(personal_profile_params)
    @personal_profile.user = @user
    @personal_profile.save!
    @announcer = Announcer.new(announcer_params)
    @announcer.user = @user
    @announcer.save!
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Anunciante cadastrado com sucesso!' }
      else
        format.html { render :new }
      end
    end
  end

  def user_params
    params.require(:user).permit(
    :email,
    :password,
    :password_confirmation
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
    :banner
    )
  end

end
