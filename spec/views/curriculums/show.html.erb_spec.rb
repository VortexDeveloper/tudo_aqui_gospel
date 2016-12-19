require 'rails_helper'

RSpec.describe "curriculums/show", type: :view do
  before(:each) do
    @curriculum = assign(:curriculum, Curriculum.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
