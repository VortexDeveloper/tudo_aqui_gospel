require 'rails_helper'

RSpec.describe "PubAttachments", type: :request do
  describe "GET /pub_attachments" do
    it "works! (now write some real specs)" do
      get pub_attachments_path
      expect(response).to have_http_status(200)
    end
  end
end
