class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @followings = followings @user
    @followers = followers @user
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: '編集しました'
    else
      render 'edit'
    end
  end
  
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area)
  end
  
  def followings user
    user.following_users
  end
  
  def followers user
    user.follower_users
  end
end
