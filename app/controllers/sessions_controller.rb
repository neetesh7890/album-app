class SessionsController < ApplicationController  
  #Layouts 
  layout "users", only:[:edit,:show]
  
  #Filter Skip
  skip_before_action :access_check, only: [:new, :create]
  skip_before_action :current_user, only: [:new, :create]

  def show   
  end

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    redirect_to users_login_path and return if @user.blank?
    @user = User.authenticate(params[:user][:email],params[:user][:password])  #passed email and password entered by user
    if @user.present?
      remember = params[:user][:remember_me]
      cookies[:password] = @user.password if remember == "1"
      session[:user_id] = @user.id 
      # If first time then edit else dashboards.
      @user.user_detail.blank? ? "#{redirect_to edit_user_path(id: @user.id)}" : "#{redirect_to user_dashboards_path(@user.id)}"
    else
      # @user = User.new
      flash[:notice] = "Invalid Credentials"
      return redirect_to users_login_path
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
