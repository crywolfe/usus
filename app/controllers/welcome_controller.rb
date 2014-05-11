class WelcomeController < ApplicationController

  def index
  end

  def create
    if user = User.authenticate(params[:name])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      session[:user_id] = user.id
      redirect_to root_url
    end
  end


end
