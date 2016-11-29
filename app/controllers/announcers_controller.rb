class AnnouncersController < ApplicationController

  def edit
    @announcer = Announcer.where("user_id = ?", current_user.id).first
  end

  def update
      @announcer = Announcer.where("user_id = ?", current_user.id).first
      if @announcer.update(announcer_params)
        redirect_to announcer_edit_url, notice: 'Dados atualizados com sucesso.'
      else
        render :edit
      end
  end

  def announcer_params
    params.require(:announcer).permit(
    :name,
    :fantasy_name,
    :contact_name,
    :dot_type,
    :doc,
    :email,
    :avatar
    )
  end

end
