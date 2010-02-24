class UserMailer < ActionMailer::Base

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Bitte aktivieren Sie Ihr neues Zugangs-Konto'
    @body[:url]  = activate_url(user.activation_code)
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Ihr Zugangs-Konto wurde aktiviert!'
    @body[:url]  = root_url
  end

  def forgot_password(user)
    setup_email(user)
    @subject    += 'Sie haben die &Auml;nderung Ihres Passworts angefordert'
    @body[:url]  = reset_password_url(user.password_reset_code)
  end

  def reset_password(user)
    setup_email(user)
    @subject    += 'Ihr Passwort wurde zur&uuml;ckgesetzt.'
  end

  protected

  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "mse.investments@googlemail.com"
    @subject     = "matze-msh "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
