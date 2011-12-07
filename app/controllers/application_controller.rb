class ApplicationController < ActionController::Base
  protect_from_forgery
  TAGS_ALLOWED = %w[table tr td li ul b i div br strong 
big em sub sup q ins del abr acronym address q cite h1 h2 h3 h4 h5 h6 bdo pre tt code 
kdb samp font p a img th caption colgroup col thead tbody tfoot ol dl dt dd form imput 
textarea label fieldset legend select optgroup option button div span embed object 
strikes ins quote blockquote u hr]  
  ATRIBUTESS_ALLOWED = %w[id class style height width]
  protected

  def autorize_user
    unless User.find_by_id(session[:user_id])
      redirect_to root_url, :notice => "Please logged in"
    end
  end
  helper_method :autorize_user

  def autorize_admin
    if session[:user_id]
     unless User.find_by_id(session[:user_id]).access_level == 100
       redirect_to root_url, :notice => "admin's zone"
     end
   else 
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
