class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to root_url, :notice => "Only for new users"
    end
      
  end

  def create  
    if session[:user_id]
      redirect_to root_url, :notice => "Only for new users"
    else
      user = User.find_by_email(params[:email])  
      if user && user.authenticate(params[:password])  
        session[:user_id] = user.id  
        redirect_to root_url, :notice => "Logged in!"  
      else  
        flash.now.alert = "Invalid email or password"  
        render "new"  
      end
    end  
  end  
  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"  
  end  
end
