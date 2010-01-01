require 'spec_helper'

describe "Layout Links" do

  it "should have a Home page at '/'" do
    get '/'
    response.should render_template('pages/home')
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should render_template('pages/contact')
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "should have a Service page at '/service'" do
    get '/service'
    response.should render_template('pages/service')
  end

  it "should have a Reference page at '/reference'" do
    get '/reference'
    response.should render_template('pages/reference')
  end

  it "should have a News page at '/news'" do
    get '/news'
    response.should render_template('pages/news')
  end

  it "should have a Impressum page at '/impressum'" do
    get '/impressum'
    response.should render_template('pages/impressum')
  end

end
