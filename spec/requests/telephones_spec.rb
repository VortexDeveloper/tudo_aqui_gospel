require 'rails_helper'

RSpec.describe "Telephones", type: :request do
  describe "GET /telephones" do
    it "works! (now write some real specs)" do
      get telephones_path
      expect(response).to have_http_status(200)
    end
  end
end
