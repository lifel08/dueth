class UsersController < ApplicationController
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def edit
    @user = current_user
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def member_since
    created_at.strftime('%B, %Y')
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :language, :birthday, :description, :photo)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

