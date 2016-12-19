require 'rails_helper'

RSpec.describe "curriculums/index", type: :view do
  before(:each) do
    assign(:curriculums, [
      Curriculum.create!(),
      Curriculum.create!()
    ])
  end

  it "renders a list of curriculums" do
    render
  end
end
