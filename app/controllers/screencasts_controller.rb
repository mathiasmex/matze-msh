class ScreencastsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :image]
  before_filter :page_setup
  require_role 'administrator', :for => [:edit, :new, :delete, :update]

  def access_denied
    flash[:notice] = "Kein Zugang. Daf&uuml;r brauchen Sie Administrator-Rechte!" if logged_in?
    flash[:notice] = "Kein Zugang. Bitte einloggen!" if !logged_in?
    redirect_to login_path
  end
  
  def page_setup
    @page_id = 'screencasts'
  end

  # GET /screencasts
  # GET /screencasts.xml
  def index
    @screencasts = Screencast.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @screencasts }
    end
  end

  # GET /screencasts/1
  # GET /screencasts/1.xml
  def show
    @screencast = Screencast.find(params[:id],
                  :include => [:product, :format,
                              {:product => [:category, :manufacturer]}])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @screencast }
    end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "No screencast with that id in database."
      redirect_to screencasts_path 
  end

  # GET /screencasts/new
  # GET /screencasts/new.xml
  def new
    @screencast = Screencast.new
    @screencast.build_product

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @screencast }
    end
  end

  # GET /screencasts/1/edit
  def edit
    @screencast = Screencast.find(params[:id])
  end

  # POST /screencasts
  # POST /screencasts.xml
  def create
    @screencast = Screencast.new(params[:screencast])
    @screencast.build_product(params[:product])
    @screencast.product.build_photo(params[:photo])

    respond_to do |format|
      if @screencast.save
        flash[:notice] = 'Screencast was successfully created.'
        format.html { redirect_to(@screencast) }
        format.xml  { render :xml => @screencast, :status => :created, :location => @screencast }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @screencast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /screencasts/1
  # PUT /screencasts/1.xml
  def update
    @screencast = Screencast.find(params[:id])

    respond_to do |format|
      if update_all
        flash[:notice] = 'Screencast was successfully updated.'
        format.html { redirect_to(@screencast) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @screencast.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /screencasts/1
  # DELETE /screencasts/1.xml
  def destroy
    @screencast = Screencast.find(params[:id])
    @screencast.destroy

    respond_to do |format|
      format.html { redirect_to(screencasts_url) }
      format.xml  { head :ok }
    end
  end

  def image
    @image_data = Photo.find(params[:id])
    @image = @image_data.binary_data
    send_data(@image, :type => @image_data.content_type,
                      :filename => @image_data.filename,
                      :disposition => 'inline')
  end

  private

  def update_all
    @screencast.transaction do
      @screencast.update_attributes(params[:screencast]) &&
      @screencast.product.update_attributes(params[:product]) &&
      @screencast.product.photo.update_attributes(params[:photo])
    end
  end
end
