class TransactionsController < ApplicationController
  before_action :authenticate_new_user, only: [:new]
  skip_before_action :verify_authenticity_token

  def new
    @transaction = Transaction.new
    session = PagSeguro::Session.create
    @session_id = session.id
    @telephone = Telephone.new
  end

  def create
    @user = User.find transaction_params[:user_id]
    # @user.profile.update(personal_profile_params)
    @user.profile.telephones.create(telephone_params)
    @transaction = Transaction.new do |t|
      t.user = @user
      t.plan = Plan.first
    end
    @transaction.card_params = card_params
    @transaction.sender_hash = transaction_params[:sender_hash]
    @transaction.payment_token = transaction_params[:payment_token]
    headers['Access-Control-Allow-Origin'] = 'https://sandbox.pagseguro.uol.com.br'
    if @transaction.save
      redirect_to success_transaction_path(@transaction)
    else
      @telephone = Telephone.new
      flash[:notice] = e.message
      render :new
    end
  end

  def payment_redirect
    headers['Access-Control-Allow-Origin'] = 'https://sandbox.pagseguro.uol.com.br'

    type = params[:notificationType]
    if type == 'preApproval'
      Transaction.update_subscription(params[:notificationCode])
    elsif type == 'transaction'
      Transaction.update_transaction(params[:notificationCode])
    else
      # envia email para tag e vortex
    end
  end

  def success
    @transaction = Transaction.find params[:id]
  end

  private
  def authenticate_new_user
    @user = User.find params[:u]

    if @user.active?
      redirect_to new_user_session_path, notice: 'Você não está autorizado a acessar esta página mas sua conta já está ativada. Pode fazer o login ou recupere a sua senha.'
    end

    if @user.created_at < 1.hour.ago
      @user.destroy!
      redirect_to new_user_registration_path, notice: 'Você não está autorizado a acessar esta página. Será necessário criar um cadastro.'
    end
  end

  def telephone_params
    params.require(:telephone).permit(
      :number
    )
  end

  def transaction_params
    params.require(:transaction).permit(
      :sender_hash,
      :payment_token,
      :user_id
    )
  end

  def personal_profile_params
    params.require(:personal_profile).permit(
      :name,
      :cpf,
      :street,
      :street_number,
      :complement,
      :neighborhood,
      :state_id,
      :city_id,
      :zip_code
    )
  end

  def card_params
    params.require(:card_params).permit(
      :card_number,
      :cvv,
      :"birth_date(3i)",
      :"birth_date(2i)",
      :"birth_date(1i)",
      :name,
      :phone,
      :cpf
    )
  end
end
