class ApplicationController < ActionController::Base  
  protect_from_forgery with: :exception    
  before_action :access_check #, except: [:new, :create,:show, :verify] #Need to move into applicaton controller. and skip this filter into other controller where its not requird. done
  private
  	def access_check 
      unless session[:user_id]
        flash[:notice] = "You must be logged in to access this section"
        redirect_to  actions_login_path # actions  controller k login neetesh gupta
      end
    end
end
