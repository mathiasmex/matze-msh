# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in? and self.current_user.state
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = "Sie haben sich erfolgreich eingelogged"
    elsif self.current_user and !current_user.state
      flash[:notice] = "Der Zugang wurde deaktiviert.
                        Bitte wenden Sie sich an den Customer Service."
      render :action => 'new'
    else
      flash[:notice] = "Die Zugangsdaten konnten nicht gefunden werde.<br />
                        Bitte pr&uuml;fen Sie Login und Passwort."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Sie wurden erfolgreich ausgelogged."
    redirect_back_or_default('/')
  end
end
