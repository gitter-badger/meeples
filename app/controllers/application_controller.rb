class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :configure_permitted_parameters, if: :devise_controller?

  respond_to :html

  self.responder = Responder

  rescue_from CanCan::AccessDenied do |exception|
    access_denied! exception
  end

protected

  # Rails 4 permitted parameters for devise only controllers
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
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
