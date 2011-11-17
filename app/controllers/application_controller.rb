class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def autorize_user
    unless User.find_by_id(session[:user_id])
      redirect_to root_url, :notice => "Please logged in"
    end
  end
  helper_method :autorize_user

  def autorize_admin
   unless User.find_by_id(session[:user_id]).access_level == 100
     redirect_to root_url, :notice => "admin's zone"
   end 
  end
  helper_method :autorize_admin

  private  
    
  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  
  helper_method :current_user  
end
