require 'rails_helper'

RSpec.describe "curriculums/new", type: :view do
  before(:each) do
    assign(:curriculum, Curriculum.new())
  end

  it "renders new curriculum form" do
    render

    assert_select "form[action=?][method=?]", curriculums_path, "post" do
    end
  end
end
