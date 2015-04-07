class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def edit
    render (params["edit_avatar"].present?) ? :edit_avatar : :edit
  end

  def update
    if @user.update(user_params)
      if params[:user][:avatar].present?
        render :crop
      else
        redirect_to edit_user_path, notice: "Successfully updated profile."
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :remove_avatar, :name, :biography, :twitter_handle, :crop_x, :crop_y, :crop_w, :crop_h)
  end

  def authorize_user
    if params[:id].to_i != current_user.id
      redirect_to root_path
    else
     @user = current_user
   end
  end
end