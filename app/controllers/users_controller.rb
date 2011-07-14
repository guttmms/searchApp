class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  
  def new
    @user = User.new
    session[:user_id] = @user.id
  end
  def index
   @users = User.all
  end
  def create
    @user = User.new(params[:user])
    
    if @user.save
      render :action => 'show'
      #redirect_to user_path(current_user)
      #redirect_to :controller => 'profiles', :action => 'show'#, :user_id => @user.id
     # session[:user_id] = @user.id
      #redirect_to :controller => 'profiles', :action => 'show', # :user_id => session[:user_id]
     # redirect_to user_path(current_user), :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end
  def show
    @user = User.find(current_user)
    #if !(@user.profile.nil?)
    #profile = @user.profile
    
    #redirect_to profile_path(profile)
    #end
    
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
  def destroy
    @user = current_user
    @user.delete
    redirect_to :controller => 'sessions', :action => 'new'
  end
end
