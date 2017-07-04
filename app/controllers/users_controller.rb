class UsersController < ApplicationController

  def edit
  end

  def update
    user = User.find(params[:id])
    user.update(user_params) if user.id == current_user.id
    redirect_to root_path
  end

end
