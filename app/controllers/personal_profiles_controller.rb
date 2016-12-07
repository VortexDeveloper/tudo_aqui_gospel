class PersonalProfilesController < ApplicationController

  def edit
    @personal_profile = PersonalProfile.where("user_id = ?", current_user.id).first
    @columnist = Columnist.where("user_id = ?", current_user.id).first
    @subscriber = Subscriber.where("user_id = ?", current_user.id).first
    @announcer = Announcer.where("user_id = ?", current_user.id).first
  end

  def update
      @personal_profile = PersonalProfile.find(params[:id])
      @personal_profile.save
      if @personal_profile.update(personal_profile_params)
        redirect_to personal_profiles_edit_url, notice: 'Perfil atualizado com sucesso.'
      else
        render :edit
      end
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

end
