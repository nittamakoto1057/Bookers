class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: 'successfully updated'
      else
        render action: :edit
      end
    else
      redirect_to user_path(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
