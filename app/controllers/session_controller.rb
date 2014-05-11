class SessionController < ApplicationController

  def new

  end

  def create
    binding.pry
    # find the user by the given email from the form
    user = User.find_by(id: params[:id])
    # if we found the user and they gave us the right password
    if user
      # store user id in session
      # the key to the flash hash can be anything, you can call it user_name, football, etc.
      session[:user_id] = user.id
      redirect_to("/")
    else
      # rerender the login form
      render(:new)
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to(root_path)
  end

end
