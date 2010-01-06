require 'spec_helper'

describe "/screencasts/edit.html.erb" do
  include ScreencastsHelper

  before(:each) do
    assigns[:screencast] = @screencast = stub_model(Screencast,
      :new_record? => false
    )
  end

  it "renders the edit screencast form" do
    render

    response.should have_tag("form[action=#{screencast_path(@screencast)}][method=post]") do
    end
  end
end
