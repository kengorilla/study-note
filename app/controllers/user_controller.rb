class UserController < ApplicationController
  before_action :forbid_login_user, {only: [:login]}
  
  def home
  end
  
  def login
    @user=User.find_by(name:params[:name], password:params[:password])
    if @user
      flash[:notice]="ログインに成功しました"
      session[:user_id] = @user.id
      redirect_to "/top"
    else
      flash[:notice]="nameかpasswordが不正です"
      render "user/home"
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
end
