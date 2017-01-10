require 'rails_helper'

RSpec.describe "pub_attachments/new", type: :view do
  before(:each) do
    assign(:pub_attachment, PubAttachment.new())
  end

  it "renders new pub_attachment form" do
    render

    assert_select "form[action=?][method=?]", pub_attachments_path, "post" do
    end
  end
end
