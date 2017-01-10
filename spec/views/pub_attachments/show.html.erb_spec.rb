require 'rails_helper'

RSpec.describe "pub_attachments/show", type: :view do
  before(:each) do
    @pub_attachment = assign(:pub_attachment, PubAttachment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
