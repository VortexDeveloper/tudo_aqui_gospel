class Transaction < ApplicationRecord
  class IntegrationErrors < StandardError; end

  belongs_to :user
  belongs_to :plan

  before_create :send_to_pagseguro
  after_save :check_status

  attr_accessor :sender_hash, :payment_token, :card_params
  enum subscription_status: [:initiated, :pending, :active,
                            :payment_method_change, :suspended, :cancelled,
                            :cancelled_by_receiver, :cancelled_by_sender,
                            :expired], _prefix: :subscription

  enum last_transaction_status: [:waiting, :analisys, :paid, :available, :contest,
                            :restored, :cancelled], _prefix: :transaction

  def send_to_pagseguro
    self.transaction_reference = mount_reference
    subscription = PagSeguro::Subscription.new transaction_params
    subscription.credentials = self.class.credentials
    subscription.create

    if subscription.errors.any?
      raise IntegrationErrors, subscription.errors.join(' ')
    else
      self.subscription_code = subscription.code
      self.last_transaction_status = :waiting
    end
  end

  class << self
    def update_subscription(notification_code)
      options = {credentials: self.credentials}
      subscription = PagSeguro::Subscription.find_by_notification_code(notification_code, {credentials: credentials})
      transaction = find_by_subscription_code subscription.code
      transaction.subscription_status = subscription.status.downcase
      transaction.save
    end

    def update_transaction(notification_code)
      options = {credentials: self.credentials}
      ptransaction = PagSeguro::Transaction.find_by_notification_code(notification_code, {credentials: credentials})
      transaction = find_by_transaction_reference ptransaction.reference
      transaction.last_transaction_status = (ptransaction.status.id.to_i - 1)
      transaction.save
    end

    def credentials
      email, token = ['tufa.araujo@hotmail.com', '947533195E6B4C6FB5F793F48BE43D2B']
      PagSeguro::AccountCredentials.new(email, token)
    end
  end

  private
  def transaction_params
    {
      plan: plan.code,
      reference: transaction_reference,
      sender: {
        name: user.name,
        email: user.email,
        hash: sender_hash,
        phone: {
          area_code: user.main_phone.number[1..2],
          number: user.main_phone.number[5..14]
        },
        document: {
          type: 'CPF',
          value: user.cpf.gsub(/\.|-/, '')
        },
        address: {
          street: user.street,
          number: user.street_number,
          complement: user.complement,
          district: user.neighborhood,
          city: user.city_name,
          state: user.state_uf,
          country: "BRA",
          postal_code: user.zip_code
        }
      },
      payment_method: {
        token: payment_token,
        holder: {
          name: card_params[:name],
          birth_date: birth_date_formatted,
          phone: {
            area_code: card_params[:phone][1..2],
            number: card_params[:phone][5..14]
          },
          document: {
            type: 'CPF',
            value: card_params[:cpf].gsub(/\.|-/, '')
          }
        }
      }
    }
  end

  def birth_date_formatted
    year = card_params[:"birth_date(1i)"]
    month = sprintf('%02d', card_params[:"birth_date(2i)"])
    day = sprintf('%02d', card_params[:"birth_date(3i)"])
    "#{day}/#{month}/#{year}"
  end

  def mount_reference
    "#{self.plan.reference}-subscriber-#{user.id}"
  end

  def check_status
    if subscription_active? && transaction_paid?
      user.active!
      UserMailer.activated_account(user).deliver_now
    else
      user.unactive!
    end
  end
end
