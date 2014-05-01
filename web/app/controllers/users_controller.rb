require 'pry-debugger'

class UsersController < ApplicationController
  def new
  end

  def signout
    TM::SignOut.run({ session_id: session[:session_id] })
    reset_session
    return redirect_to root_path
  end

  def create
    if params[:password] != params[:password_confirmation]
      flash[:notice] = "Passwords don't match, mf"
      return redirect_to signup_path
    end

    result = TM::CreateUser.run({ username: params[:username], password: params[:password] })
    if result.success?
      result = TM::SignIn.run({ username: params[:username], password: params[:password] })
      session[:tm_session_id] = result.session_id
    elsif result.error == :username_taken
      flash[:notice] = "mf, that username is taken."
      return redirect_to signup_path
    end
  end

  def sign_in_form
  end

  def sign_in
    result = TM::SignIn.run({ username: params[:username], password: params[:password] })
    if result.success?
      session[:tm_session_id] = result.session_id
      return redirect_to select_artist_path
    else
      flash[:notice] = "something you typed in don't smell right"
      binding.pry
    end
  end

  def select_artist
  end
end
