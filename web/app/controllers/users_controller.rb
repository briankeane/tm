class UsersController < ApplicationController
  def new
  end

  def signout
    TM::SignOut.run({ session_id: session[:session_id] })
    sessions[:session_id] = nil
    return redirect_to root
  end
end
