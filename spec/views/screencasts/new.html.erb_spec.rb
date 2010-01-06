require 'spec_helper'

describe "/screencasts/new.html.erb" do
  include ScreencastsHelper

  before(:each) do
    assigns[:screencast] = stub_model(Screencast,
      :new_record? => true
    )
  end

  it "renders new screencast form" do
    render

    response.should have_tag("form[action=?][method=post]", screencasts_path) do
    end
  end
end
