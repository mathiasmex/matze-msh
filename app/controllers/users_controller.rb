class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  # Protect these actions behind an admin login
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  before_filter :login_required, :except => [:new, :create, :forgot_password, :reset_password]
  before_filter :page_setup
  require_role "administrator", :for => [:index, :destroy, :enable]
  before_filter :find_user, :only => [:suspend, :unsuspend, :destroy, :enable]
  
  def page_setup
    @page_id = 'users'
  end

  def access_denied
    flash[:notice] = "Kein Zugang. Daf&uuml;r brauchen Sie Administrator-Rechte!" if logged_in?
    flash[:notice] = "Kein Zugang. Bitte einloggen!" if !logged_in?
    redirect_to login_path
  end
    
  # render new.rhtml
  def new
  end

  def index
    @users = User.all
  end

  def show
    begin
      @user = User.find(params[:id])
      if @user and (current_user == @user)
        return @user
      else
        flash[:notice] = "Kein Zugang. Bitte erneut versuchen."
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Falsche Benutzer-Nummer. Bitte erneut versuchen."
    end
    redirect_to signup_path
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.register! if @user.valid?
    if @user.errors.empty?
    #  self.current_user = @user
    #  redirect_back_or_default('/')
      flash[:notice] = "Danke f&uuml;r die Registrierung!"
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.roles << Role.find_by_name('customer')
      current_user.activate!
      flash[:notice] = "Registrierung erfolgreich!"
    end
    redirect_back_or_default('/')
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attribute(:state, 'passive')
      flash[:notice] = "Benutzer deaktiviert"
    else
      flash[:error] = "Beim deaktivieren des Benutzers ist ein Problem aufgetreten."
    end
    redirect_to :action => 'index'
  end

  def purge
    @user.destroy
    redirect_to users_path
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:state, 'active')
      flash[:notice] = "Benutzer aktiviert"
    else
      flash[:error] = "Beim aktivieren des Benutzers ist ein Problem aufgetreten."
    end
    redirect_to :action => 'index'
  end

  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && 
          !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]

        if current_user.save
          flash[:notice] = "Passwort erfolgreich ge&auml;ndert" 
          redirect_back_or_default('/')
        else
          flash[:alert] = "Das Passwort konnte nicht ge&auml;ndert werden" 
        end

      else
        flash[:alert] = "Neues Passwort stimmt nicht &uuml;berein" 
        @old_password = params[:old_password]
      end
    else
      flash[:alert] = "Das eingegebene Passwort ist falsch" 
    end
  end

  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:user][:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default('/')
      flash[:notice] = "Ein link zum zur&uuml;cksetzen des Passworts wurde an Ihre E-Mail-Adresse geschickt" 
    else
      flash[:alert] = "Ein Benutzer mit dieser E-Mail konnte nicht gefunden werden" 
    end
  end

  def reset_password
    @user = User.find_by_password_reset_code(params[:id])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]) && 
        !params[:user][:password_confirmation].blank?)
      self.current_user = @user #for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Passwort erfolgreich zur&uuml;ckgesetzt." : "Zur&uuml;cksetzen des Passworts fehlgeschlagen." 
      redirect_back_or_default('/')
    else
      flash[:alert] = "Passwort stimmt nicht &uuml;berein" 
    end  
  end

protected
  def find_user
    @user = User.find(params[:id])
  end

end
