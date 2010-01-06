require 'spec_helper'

describe "/screencasts/index.html.erb" do
  include ScreencastsHelper

  before(:each) do
    assigns[:screencasts] = [
      stub_model(Screencast),
      stub_model(Screencast)
    ]
  end

  it "renders a list of screencasts" do
    render
  end
end
