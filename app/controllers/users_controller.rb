class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.select("name", "id", "profile_image_id")
    @book = Book.new
    # logger.debug @users.inspect
  end

  def show
    @book = Book.new
    @books = Book.where(user_id: params[:id])
    @user = User.find(params[:id])
  end

  def edit
    if current_user.id.to_s != params[:id]
      redirect_to user_path(current_user.id)
    end

    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

    if user.update(update_user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to user_path(params[:id])
    else
      flash[:error] = user.errors.full_messages
      redirect_to user_path
    end
  end

  private
  def update_user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
