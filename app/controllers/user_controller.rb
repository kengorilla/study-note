class UserController < ApplicationController
  before_action :forbid_login_user, {only: [:login]}
  
  def create
    @user=User.new(name:params[:name],password:params[:password])
    if @user.save
      flash[:notice]="Succeeded to signup! You are logged in!"
      session[:user_id] = @user.id
      redirect_to "/top"
    else
      @error_messages = @user.errors.full_messages
      flash[:notice]="Signup failed"
      render "user/signup"
    end
  end
  
  def signup
  end
  
  def login
    @user=User.find_by(name:params[:name], password:params[:password])
    if @user
      flash[:notice]="Logged in!"
      session[:user_id] = @user.id
      redirect_to "/top"
    else
      flash[:notice]="Name or Password is incorrect"
      render "user/home"
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to("/")
  end
  
  def index
    @users=User.all
  end
end
