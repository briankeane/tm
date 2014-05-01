class OpeningPagesController < ApplicationController
  def welcome
    puts "SESSION: #{session[:tm_session_id].inspect}"
  end

  def about
  end
end
