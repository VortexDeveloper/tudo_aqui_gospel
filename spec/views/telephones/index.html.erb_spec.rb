require 'rails_helper'

RSpec.describe "telephones/index", type: :view do
  before(:each) do
    assign(:telephones, [
      Telephone.create!(),
      Telephone.create!()
    ])
  end

  it "renders a list of telephones" do
    render
  end
end
