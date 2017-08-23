 class DashboardsController < ApplicationController
	
  #Actions
  def index
    @detail = UserDetail.find_by(user_id: @user.id) 
	end  

	def information
		@user = User.find_by(id: params[:id])
	end
end
