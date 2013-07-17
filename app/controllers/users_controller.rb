class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:index, :destroy]

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    puts @user.email
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
end
