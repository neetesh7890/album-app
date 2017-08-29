 class DashboardsController < ApplicationController
	
  #Actions
  def index
    @detail = UserDetail.find_by(user_id: @user.id) 
	end  
  
end
