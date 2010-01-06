require 'spec_helper'

describe ScreencastsController do

  def mock_screencast(stubs={})
    @mock_screencast ||= mock_model(Screencast, stubs)
  end

  describe "GET index" do
    it "assigns all screencasts as @screencasts" do
      Screencast.stub!(:find).with(:all).and_return([mock_screencast])
      get :index
      assigns[:screencasts].should == [mock_screencast]
    end
  end

  describe "GET show" do
    it "assigns the requested screencast as @screencast" do
      Screencast.stub!(:find).with("37").and_return(mock_screencast)
      get :show, :id => "37"
      assigns[:screencast].should equal(mock_screencast)
    end
  end

  describe "GET new" do
    it "assigns a new screencast as @screencast" do
      Screencast.stub!(:new).and_return(mock_screencast)
      get :new
      assigns[:screencast].should equal(mock_screencast)
    end
  end

  describe "GET edit" do
    it "assigns the requested screencast as @screencast" do
      Screencast.stub!(:find).with("37").and_return(mock_screencast)
      get :edit, :id => "37"
      assigns[:screencast].should equal(mock_screencast)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created screencast as @screencast" do
        Screencast.stub!(:new).with({'these' => 'params'}).and_return(mock_screencast(:save => true))
        post :create, :screencast => {:these => 'params'}
        assigns[:screencast].should equal(mock_screencast)
      end

      it "redirects to the created screencast" do
        Screencast.stub!(:new).and_return(mock_screencast(:save => true))
        post :create, :screencast => {}
        response.should redirect_to(screencast_url(mock_screencast))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved screencast as @screencast" do
        Screencast.stub!(:new).with({'these' => 'params'}).and_return(mock_screencast(:save => false))
        post :create, :screencast => {:these => 'params'}
        assigns[:screencast].should equal(mock_screencast)
      end

      it "re-renders the 'new' template" do
        Screencast.stub!(:new).and_return(mock_screencast(:save => false))
        post :create, :screencast => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested screencast" do
        Screencast.should_receive(:find).with("37").and_return(mock_screencast)
        mock_screencast.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :screencast => {:these => 'params'}
      end

      it "assigns the requested screencast as @screencast" do
        Screencast.stub!(:find).and_return(mock_screencast(:update_attributes => true))
        put :update, :id => "1"
        assigns[:screencast].should equal(mock_screencast)
      end

      it "redirects to the screencast" do
        Screencast.stub!(:find).and_return(mock_screencast(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(screencast_url(mock_screencast))
      end
    end

    describe "with invalid params" do
      it "updates the requested screencast" do
        Screencast.should_receive(:find).with("37").and_return(mock_screencast)
        mock_screencast.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :screencast => {:these => 'params'}
      end

      it "assigns the screencast as @screencast" do
        Screencast.stub!(:find).and_return(mock_screencast(:update_attributes => false))
        put :update, :id => "1"
        assigns[:screencast].should equal(mock_screencast)
      end

      it "re-renders the 'edit' template" do
        Screencast.stub!(:find).and_return(mock_screencast(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested screencast" do
      Screencast.should_receive(:find).with("37").and_return(mock_screencast)
      mock_screencast.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the screencasts list" do
      Screencast.stub!(:find).and_return(mock_screencast(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(screencasts_url)
    end
  end

end
