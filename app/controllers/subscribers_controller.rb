class SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token
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

  def canceled_subscription

  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.set_roles(params[:roles])
      @user.profile.update personal_profile_params
      # @subscriber = @user.subscriber
      # @subscriber.update subscriber_params
      sign_in(@user, scope: :user)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Parabéns, você finalizou seu cadastro, para ter acesso completo ao nosso conteúdo, é necessário fazer a assinatura. Obrigado!' }
      end
    else
        respond_to do |format|
            messages = []
            @user.errors.full_messages.each { |msg| messages << "<li>#{msg}</li>" }
            flash[:new_user_errors] = messages.join
            session[:user_error] = @user
            session[:profile_error] = personal_profile_params
            # session[:subscriber_error] = subscriber_params
          format.html { redirect_to new_subscriber_path }
        end
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
