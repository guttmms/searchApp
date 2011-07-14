class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      profile = user.profile
      redirect_to profile_path(profile)
      #redirect_to_target_or_default profile_path(session[:user_id]), :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to 'new', :notice => "You have been logged out."
  end
end
