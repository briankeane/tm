class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  def current_user
    TM::Database.db.get_user(session(:session_id))
  end

  protect_from_forgery with: :exception
end
