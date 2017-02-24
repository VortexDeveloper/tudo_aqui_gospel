class TransactionsController < ApplicationController
  before_action :authenticate_new_user, only: [:new]

  def new
    @transaction = Transaction.new
    @user = User.find params[:u]
    session = PagSeguro::Session.create
    @session_id = session.id
    @telephone = Telephone.new
  end

  def create
    @user = User.find transaction_params[:user_id]
    @user.profile.update(personal_profile_params)
    @user.profile.telephones.create(telephone_params)
    @transaction = Transaction.new do |t|
      t.user = @user
      t.plan = Plan.first
    end
    @transaction.card_params = card_params
    @transaction.sender_hash = transaction_params[:sender_hash]
    @transaction.payment_token = transaction_params[:payment_token]

    if @transaction.save
      redirect_to success_transaction_path(@transaction)
    else
      @telephone = Telephone.new
      flash[:notice] = e.message
      render :new
    end
  end

  def validate_transaction
  end

  def success
    @transaction = Transaction.find params[:id]
  end

  private
  def authenticate_new_user
    # verificar se foi criado recentemente
    # verificar se está inativo
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
