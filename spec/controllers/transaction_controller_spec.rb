require 'rails_helper'

RSpec.describe TransactionController, type: :controller do

  describe "GET #validate_transaction" do
    it "returns http success" do
      get :validate_transaction
      expect(response).to have_http_status(:success)
    end
  end

end
