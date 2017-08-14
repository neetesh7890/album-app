class ApplicationController < ActionController::Base  
  # Filters
  protect_from_forgery with: :exception    
  before_action :access_check #, except: [:new, :create,:show, :verify] #Need to move into applicaton controller. and skip this filter into other controller where its not requird. done
  before_action :current_user

  # Private methods
  private
  	def access_check 
      unless session[:user_id]
        flash[:notice] = "You must be logged in to access this section"
        redirect_to actions_login_path # actions  controller k login
      end
    end

    def current_user
      @user = User.find(session[:user_id])
    end
end
