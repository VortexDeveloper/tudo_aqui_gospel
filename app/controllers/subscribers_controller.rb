class SubscribersController < ApplicationController

  def edit
    @subscriber = current_user.subscriber
  end

  def update
      @subscriber = current_user.subscriber
      if @subscriber.update(subscriber_params)
        redirect_to subscribers_edit_url, notice: 'Dados atualizado com sucesso.'
      else
        render :edit
      end
  end

  def subscriber_params
    params.require(:subscriber).permit(
    :christian,
    :church,
    :birth_date,
    :sex,
    :christian_denomination,
    :avatar
    )
  end

end
