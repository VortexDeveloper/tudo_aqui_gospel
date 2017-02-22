class Plan < ApplicationRecord
  class IntegrationErrors < StandardError; end

  before_create :send_to_pagseguro

  private
  def send_to_pagseguro
    email, token = credentials
    plan = PagSeguro::SubscriptionPlan.new plan_params
    plan.credentials = PagSeguro::AccountCredentials.new(email, token)
    plan.create

    if plan.errors.any?
      raise IntegrationErrors, plan.errors.join('\n')
    else
      self.code = plan.code
    end
  end

  # virá de algum controlador
  def plan_params
    plan = {
      redirect_url: "https://localhost:3000/transaction/1/validate_transaction",
      review_url: "https://localhost:3000/transaction/1/validate_transaction",
      # cancel_url: "https://localhost:3000/transaction/1/validate_transaction",
      charge: 'auto',
      reference: self.reference,
      name: self.name,
      details: self.details,
      period: self.period,
      amount: self.price,
      sender: {
        name: 'Tudo Aqui Gospel',
        email: 'contato@vortexdeveloper.com'
      }
    }

    if self.expire?
      plan[:final_date] = self.duration_in_months.months.from_now
      plan[:max_total_amount] = self.price*self.duration_in_months
    end
    plan[:trial_duration] = self.trial_duration if self.trial_duration > 0
    plan
  end
  
  def credentials
    ['tufa.araujo@hotmail.com', '947533195E6B4C6FB5F793F48BE43D2B']
  end
end
