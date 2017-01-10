require 'rails_helper'

RSpec.describe "pub_attachments/index", type: :view do
  before(:each) do
    assign(:pub_attachments, [
      PubAttachment.create!(),
      PubAttachment.create!()
    ])
  end

  it "renders a list of pub_attachments" do
    render
  end
end
