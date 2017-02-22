class TransactionController < ApplicationController
  before_action :authenticate_new_user, only: [:new]
  
  def new
    @transaction = Transaction.new
    @user = User.find params[:user_id]
    # session = PagSeguro::Session.create
    # @session_id = session.id
  end

  def create

  end

  def validate_transaction
  end

  private
  def authenticate_new_user
    # verificar se foi criado recentemente
    # verificar se está inativo
  end
end
