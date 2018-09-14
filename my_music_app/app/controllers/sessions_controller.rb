class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :require_logout, only: [:new, :create]
  #no session model
  def new
    @user = User.new
    render :new
  end

  #need to find a person by their email and password
  #these people are already created, and need to login
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login_in_user!(@user)
      #because it's a show, you want to pass a user (extract the id)
      redirect_to user_url(@user)
    else
      flash.now[:errors] << ['Invalid login credentials']
      render :new
    end
  end

  def destroy
    #login back in once i logged out 
    logout
    redirect_to new_session_url
  end

end
