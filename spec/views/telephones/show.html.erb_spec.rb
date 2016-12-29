require 'rails_helper'

RSpec.describe "telephones/show", type: :view do
  before(:each) do
    @telephone = assign(:telephone, Telephone.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
