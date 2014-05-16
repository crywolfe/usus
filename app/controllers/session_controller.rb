class SessionController < ApplicationController

  def new

    @member_id = params[:session][:member_id]

    if User.find_by(member_id: @member_id) != nil
      redirect_to new_search_path
    else
      redirect_to new_user_path
    end
  end

  def create
    # find the user by the given email from the form
    user = User.find_by(id: params[:id])
    # if we found the user and they gave us the right password
    if user
      # store user id in session
      # the key to the flash hash can be anything, you can call it user_name, football, etc.
      session[:user_id] = user.id

      # take session cookie for user and validate signature to ensure legitimacy
      





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
