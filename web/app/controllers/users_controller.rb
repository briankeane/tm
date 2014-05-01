require 'pry-debugger'

class UsersController < ApplicationController
  def new
  end

  def signout
    flash("Signing Out")
    TM::SignOut.run({ session_id: session[:session_id] })
    reset_session
    return redirect_to root_path
  end

  def create
    if params[:password] != params[:password_confirmation]
      flash[:notice] = "Passwords don't match, mf"
      return redirect_to signup_path
    end

    result = TM::SignUp.run({ username: params[:username], password: params[:password] })
    if result.success?
      TM::SignIn.run({ username: params[:username], password: params[:password] })
    else

  end

end
