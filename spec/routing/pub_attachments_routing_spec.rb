require "rails_helper"

RSpec.describe PubAttachmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pub_attachments").to route_to("pub_attachments#index")
    end

    it "routes to #new" do
      expect(:get => "/pub_attachments/new").to route_to("pub_attachments#new")
    end

    it "routes to #show" do
      expect(:get => "/pub_attachments/1").to route_to("pub_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pub_attachments/1/edit").to route_to("pub_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pub_attachments").to route_to("pub_attachments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pub_attachments/1").to route_to("pub_attachments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pub_attachments/1").to route_to("pub_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pub_attachments/1").to route_to("pub_attachments#destroy", :id => "1")
    end

  end
end
