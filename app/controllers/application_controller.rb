class ApplicationController < ActionController::Base

  protect_from_forgery

  self.responder = Responder

  rescue_from CanCan::AccessDenied do |exception|
    access_denied!
  end

  def after_sign_in_path_for resource
    resource.admin? ? admin_dashboard_path : root_path
  end

private

  # Called by activeadmin when authorization fails
  #
  # @param exception [StandardError
  def access_denied! exception
    redirect_to main_app.root_path, flash: { error: exception.message }
  end

  def requires_admin!
    authenticate_user!
    redirect_to '/' unless warden.user.admin?
  end

end
