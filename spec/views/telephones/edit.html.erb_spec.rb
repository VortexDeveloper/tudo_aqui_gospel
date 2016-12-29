require 'rails_helper'

RSpec.describe "telephones/edit", type: :view do
  before(:each) do
    @telephone = assign(:telephone, Telephone.create!())
  end

  it "renders the edit telephone form" do
    render

    assert_select "form[action=?][method=?]", telephone_path(@telephone), "post" do
    end
  end
end
