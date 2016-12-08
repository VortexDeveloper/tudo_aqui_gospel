class AnnouncersController < ApplicationController

  def edit
    @announcer = Announcer.find(params[:id])
    @personal_profile = PersonalProfile.where("user_id = ?", @announcer.user_id).first
    @photo = Gallery.new
  end

  def show
    @announcer = Announcer.find(params[:id])
    @personal_profile = PersonalProfile.where("user_id = ?", @announcer.user_id).first
  end

#  def update
#      @announcer = Announcer.where("user_id = ?", current_user.id).first
#      if @announcer.update(announcer_params)
#        redirect_to announcer_edit_url, notice: 'Dados atualizados com sucesso.'
#      else
#        render :edit
#      end
#  end

  def add_photo
    byebug
    announcer = Announcer.where("user_id = ?", current_user).first
    announcer.photos << Gallery.new(photo_params)
    announcer.save!
    redirect_to edit_announcer_path(announcer)
  end


  def update
    @announcer = Announcer.where("user_id = ?", current_user).first
    respond_to do |format|
      if @announcer.update(announcer_params)
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
    if user_signed_in?
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    end
  end

  def create
    @user = User.create!(user_params)
    @user.profile.update personal_profile_params
    @user.create_announcer announcer_params
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Anunciante cadastrado com sucesso!' }
      format.html { render :new }
    end
  end

  def photo_params
    params.require(:photo).permit(
    :image
    )
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
    :banner,
    :about_text
    )
  end

end
