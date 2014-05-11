class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create

    # name = user_params['user']['name']

    @user = User.new(user_params)
    @user.save
    redirect_to("/searches/new")

  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :city,
      :state,
      :zip,
      :current_position_title,
      :employment_status,
      :company_name,
      :member_id
    )
  end

end
