class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :restrict_access_by_token

  private
    def restrict_access_by_token
      authenticate_or_request_with_http_token do |token, options|
        @current_user = User.find_by_authentication_token(token)
        @current_user ||= false
      end
    end
    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(user:[:email, :password]) }
  end
end
