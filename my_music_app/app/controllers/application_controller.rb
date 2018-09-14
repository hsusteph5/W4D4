class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  #login , logout #current_user?
  #login in an user, you want to set the session token
  #user will have the session token
  def login_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end


#for the current_user you want to find them
#find them in your database by looking up the browser session token
  def current_user
    #basically once you are redirected after logging in successfully,
    #redirected so , you need to find your user again
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  #when you logout, you want to reset the session token
  #you want to reset the user's session_token
  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end


  #look at the current user
  #if the current user exists, should return true
  #call the method
  #returns false if the current user does not exist
  def logged_in?
    !!current_user
  end

  #if they are not logged in, ask them to login
  def require_login
    redirect_to new_session_url unless logged_in?
  end

  #if they are logged in, ??????
  def require_logout
    redirect_to users_url if logged_in?
  end
end

#Questions, why does current user ||=
