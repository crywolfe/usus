class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
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
      :member_id,
      :linkedin_profile_link
    )
  end

end
