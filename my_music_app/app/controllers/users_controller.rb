class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def show
    # debugger
    #params pulling route path (url)
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash.now[:errors] << "Invalid user"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_in_user!(@user)
      redirect_to new_user_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  #require the users and permit the username and password
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
