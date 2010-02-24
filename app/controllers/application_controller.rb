# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :configure_mailer

  def configure_mailer
    ActionMailer::Base.default_url_options[:host] = defined?(SITE) ? SITE: request.host
    ActionMailer::Base.default_url_options[:port] = request.port unless request.port == 80
  end

  # Authenticatedsystem must be included in RoleRequirement,
  # and is provided by installing acts_as_authenticated and running
  # 'script/generate autehnticated account user'.
  include AuthenticatedSystem

  # You can move this into a different controller, if you wish.
  # This module gives you the require_role helpers, and others.
  include RoleRequirementSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  protect_from_forgery 

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

end
