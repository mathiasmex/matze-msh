require 'spec_helper'

describe ScreencastsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/screencasts" }.should route_to(:controller => "screencasts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/screencasts/new" }.should route_to(:controller => "screencasts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/screencasts/1" }.should route_to(:controller => "screencasts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/screencasts/1/edit" }.should route_to(:controller => "screencasts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/screencasts" }.should route_to(:controller => "screencasts", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/screencasts/1" }.should route_to(:controller => "screencasts", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/screencasts/1" }.should route_to(:controller => "screencasts", :action => "destroy", :id => "1") 
    end
  end
end
