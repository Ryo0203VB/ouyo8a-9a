class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @users = User.all
    @user = current_user
 end

  def edit
    @user = User.find(params[:id])
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] =  "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def follows
   user = User.find(params[:id])
   @users = user.following_users
 end

 def followers
   user = User.find(params[:id])
   @user = user.follower_users
 end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
