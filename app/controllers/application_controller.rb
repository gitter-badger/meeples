class ApplicationController < ActionController::Base

  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html

  self.responder = Responder

  rescue_from CanCan::AccessDenied do |exception|
    access_denied! exception
  end

protected

  # Rails 4 permitted parameters for devise only controllers
  def configure_permitted_parameters
    devise_parameter_sanitizer.for :account_update do |user|
      user.permit %i[ current_password email password password_confirmation username ]
    end

    devise_parameter_sanitizer.for :sign_in do |user|
      user.permit %i[ login username email password remember_me ]
    end

    devise_parameter_sanitizer.for :sign_up do |user|
      user.permit %i[ email password password_confirmation remember_me username ]
    end
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
