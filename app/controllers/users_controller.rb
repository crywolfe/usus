class UsersController < ApplicationController

  def new
    @user =User.new
  end

  def create

    @user = User.create(user_params)
    redirect_to "/"

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
      :city,
      :state,
      :zip,
      :current_position_title,
      :employment_status,
      :company_name,
      :member_id,
      :linkedin_profile_link,
      :enterprise_status,
      :admin_status
    )
  end

end




