class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  # create a private method named "current_user" so that we can access it in any controller.
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # make sure that only logged in users can access the controller
  def require_login 
    if session[:user_id] == nil
      redirect_to root_path
    end
  end

  helper_method :current_user
  helper_method :require_login
end
