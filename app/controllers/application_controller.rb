class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user
  
  
  def set_current_user
    @current_user=User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "Please log in"
      redirect_to("/")
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:notice] = "You are logged in"
      redirect_to("/note/index")
    end
  end
  
end
