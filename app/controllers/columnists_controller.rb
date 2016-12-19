class ColumnistsController < ApplicationController


  def show
  end

  def edit
    @columnist = Columnist.where("user_id = ?", current_user.id).first
  end

  def update
      @columnist = Columnist.where("user_id = ?", current_user.id).first
      if @columnist.update(columnist_params)
        redirect_to columnists_edit_url, notice: 'Dados atualizados com sucesso.'
      else
        render :edit
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

end
