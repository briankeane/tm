require 'pry-debugger'

class UsersController < ApplicationController
  def new
  end

  def create
    if params[:password] != params[:password_confirmation]
      flash[:notice] = "Passwords don't match, mf"
      return redirect_to sign_up_path
    end
    result = TM::CreateUser.run({ username: params[:username], password: params[:password] })
    if result.success?
      result = TM::SignIn.run({ username: params[:username], password: params[:password] })
      session[:tm_session_id] = result.session_id
      redirect_to select_artist_path
    elsif result.error == :username_taken
      flash[:notice] = "mf, that username is taken."
      return redirect_to sign_up_path
    end
  end

  def select_artist
    if !signed_in?
      flash[:notice] = "Please sign in"
      redirect_to root_path
    else
      result = TM::GetArtistsByUser.run(current_user.id)
      @artists = result.artists
    end
  end
end
