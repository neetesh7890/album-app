class ApplicationController < ActionController::Base  
  protect_from_forgery with: :exception    
  
  #Filters
  before_action :access_check #, except: [:new, :create,:show, :verify] #Need to move into applicaton controller. and skip this filter into other controller where its not requird. done
  before_action :current_user
  
  #Private Methods
  private
  	def access_check 
      unless session[:user_id]
        flash[:notice] = "You must be logged in to access this section"
        redirect_to users_login_path
      end
    end
    
    def current_user
      if User.find_by(id: session[:user_id]).present?
        @user = User.find_by(id: session[:user_id]) 
      else
        session[:user_id] = nil
      end
    end
end
