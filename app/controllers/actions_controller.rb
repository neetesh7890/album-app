class ActionsController < ApplicationController
	skip_before_action :access_check, only: [:login,:new,:create,:reset_password, :update_password]
	before_action :session_activity, only:[:login,:new]
	def login
		@user = User.new
	end

	def logout
		session[:user_id] = nil
    redirect_to actions_login_path, :notice => "Logged out!"
	end
	
	def new
		@user = User.new
	end
	
	def create
		email = params[:user][:email]
		@user = User.find_by(email: email)		
		if @user.present?
			flash[:notice] = "A reset link has been sent to your email please check email"
			UserMailer.forgot_email(@user).deliver_later
			render 'new'
		else
			render 'index'
		end
	end

	def reset_password
		@user = User.find_by(id: params[:id])
	end

	def update_password
		@user = User.find_by(id: params[:id])
		@user.password = params["user"]["password"]
		if @user.save   #check please
			flash[:notice] = "Password Updated"
			redirect_to root_path
		end
	end
	
	def show
	end

	def edit
		# id = params[:id]
		if params[:id].present?
			@user = User.find(params[:id])	
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		@user.password = params[:user][:password]
		if @user.update(params.require(:user).permit(:password))
			redirect_to forgot_password_path(@user)	
		else
			flash[:notice] = "Profile Could not updated"
		end
		#VK : Need to check if update then redirect, otherwise redirect back with some notice. done
	end

	private
		def session_activity
      if session[:user_id]
        redirect_to dashboards_path
      end
    end
	
end
