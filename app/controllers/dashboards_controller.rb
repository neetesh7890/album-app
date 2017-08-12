 class DashboardsController < ApplicationController
	
	def index #if session exist then come here
	  @user = User.find_by(id: session[:user_id])
	  @detail = UserDetail.find_by(user_id: @user.id) 
	end  

	def information
		@user = User.find_by(id: params[:id])
	end
end
