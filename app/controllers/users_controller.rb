class UsersController < ApplicationController

  def edit
  end

  def update
    user = User.find(params[:id])
    if user.id == current_user.id
      user.update(user_params)
      redirect_to controller: :messages, action: :index
    else
      redirect_to new_user_session_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
