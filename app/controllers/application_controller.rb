class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Require users to sign in before using the app
  before_action :authenticate_user!

  # Allow Devise to accept additional fields like :first_name and :last_name
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redirect to login after logout
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  protected

  # Permit :first_name and :last_name for sign_up and account_update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name ])
  end
end
