class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :signed_in?

  def current_user
    TM::Database.db.get_user(session(:session_id))
  end

  def signed_in?
    #session[:session_id] != nil
    false
  end

  protect_from_forgery with: :exception
end
