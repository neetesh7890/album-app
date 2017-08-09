class SessionsController < ApplicationController  
  layout "users", only:[:edit,:show]
  skip_before_action :access_check, only: [:new, :create]

  def show   
  end

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:user][:email],params[:user][:password])  #passed email and password entered by user
    if @user.present?
      remember = params[:user][:remember_me]
      cookies[:password] = @user.password if remember == "1"
      session[:user_id] = @user.id 
      # If first time then edit else dashboards.
      @user.user_detail.blank? ? "#{redirect_to edit_user_path(id: @user.id)}" : "#{redirect_to dashboards_path}" 
    else
      # @user = User.new
      flash[:notice] = "Invalid Credentials"
      return redirect_to actions_login_path
    end    
  end

  def show    
  end

  def edit
  end

  def update
  end
  
  def destroy  
  end
end
