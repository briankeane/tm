require 'pry-debugger'

class SessionsController < ApplicationController

  def sign_in

  end

  def create
    result = TM::SignIn.run({ username: params[:username], password: params[:password] })
    if result.success?
      session[:tm_session_id] = result.session_id
      return redirect_to select_artist_path
    else
      flash[:notice] = "something you typed don't smell right"
      return redirect_to sign_in_path
    end
  end

  def sign_out
    TM::SignOut.run({ session_id: session[:session_id] })
    reset_session
    return redirect_to root_path
  end


  def destroy
  end
end
