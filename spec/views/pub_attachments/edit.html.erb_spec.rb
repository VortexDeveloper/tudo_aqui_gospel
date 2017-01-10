require 'rails_helper'

RSpec.describe "pub_attachments/edit", type: :view do
  before(:each) do
    @pub_attachment = assign(:pub_attachment, PubAttachment.create!())
  end

  it "renders the edit pub_attachment form" do
    render

    assert_select "form[action=?][method=?]", pub_attachment_path(@pub_attachment), "post" do
    end
  end
end
