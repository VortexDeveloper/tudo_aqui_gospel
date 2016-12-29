require 'rails_helper'

RSpec.describe "telephones/new", type: :view do
  before(:each) do
    assign(:telephone, Telephone.new())
  end

  it "renders new telephone form" do
    render

    assert_select "form[action=?][method=?]", telephones_path, "post" do
    end
  end
end
