require 'spec_helper'

describe "/screencasts/show.html.erb" do
  include ScreencastsHelper
  before(:each) do
    assigns[:screencast] = @screencast = stub_model(Screencast)
  end

  it "renders attributes in <p>" do
    render
  end
end
