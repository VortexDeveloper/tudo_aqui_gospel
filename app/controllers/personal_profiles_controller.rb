class PersonalProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @telephone = Telephone.new
  end

  def update
      @personal_profile = PersonalProfile.find(params[:id])
      @personal_profile.save
      if @personal_profile.update(personal_profile_params)
        if current_user.active?
          redirect_to personal_profiles_edit_url, notice: 'Perfil atualizado com sucesso.'
        else
          redirect_to new_transaction_path, notice: 'Agora falta apenas realizar o pagamento!'
        end
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
    :city,
    :state_id,
    :state,
    :country_id,
    :zip_code
    )
  end

end
