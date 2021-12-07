class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?
  before_action :no_login
  # before_action :default_url_options
	 def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end

  def no_login
    if !logged_in?
      redirect_to login_path
    end
  end
  
end
