class UsersController < ApplicationController
  def update
    @user.update(user_params)
    redirect_to user_profile_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to edit_user_registration_path(@user.id)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday, :password, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

