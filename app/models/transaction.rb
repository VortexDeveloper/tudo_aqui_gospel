class Transaction < ApplicationRecord
  class IntegrationErrors < StandardError; end

  belongs_to :user
  belongs_to :plan

  before_create :send_to_pagseguro

  attr_accessor :sender_hash, :payment_token, :card_params

  def send_to_pagseguro
    email, token = credentials
    subscription = PagSeguro::Subscription.new transaction_params
    subscription.credentials = PagSeguro::AccountCredentials.new(email, token)
    subscription.create

    if subscription.errors.any?
      raise IntegrationErrors, subscription.errors.join(' ')
    else
      self.subscription_code = subscription.code
    end
  end

  private
  def transaction_params
    {
      plan: self.plan.code,
      reference: self.plan.reference,
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
          value: user.cpf
        },
        address: {
          street: user.street,
          number: user.street_number,
          complement: user.complement,
          district: user.neighborhood,
          city: user.city_name,
          state: user.state_uf,
          country: user.country_code,
          postal_code: user.zip_code
        }
      },
      payment_method: {
        token: payment_token,
        holder: {
          name: card_params[:name],
          birth_date: card_params[:birth_date],
          phone: {
            area_code: card_params[:phone][1..2],
            number: card_params[:phone][5..14]
          },
          document: {
            type: 'CPF',
            value: card_params[:cpf]
          }
        }
      }
    }
  end

  def credentials
    ['tufa.araujo@hotmail.com', '947533195E6B4C6FB5F793F48BE43D2B']
  end
end
