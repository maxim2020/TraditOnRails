class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :discard_flash_if_xhr
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

end
