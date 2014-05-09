class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    @user.save

  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    require(:user).permit(
      :name,
      :email,
      :password,
      :city,
      :state,
      :zip,
      :current_position_title,
      :employment_status,
      :company_name
    )
  end

end
