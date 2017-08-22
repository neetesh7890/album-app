class UsersController < ApplicationController

  #Layouts
  # layout :compute_layout
  layout "special_layout", only: [:new,:create,:create_account_help,:reset_password ]

  #Filters
  before_action :session_activity, only:[:new,:new_account_help,:login]

  #Filters skip
  skip_before_action :current_user, only: [:new,:create,:reset_password, :update_password,:show,:verify,:new_account_help,:create_account_help]
  skip_before_action :access_check, only: [:new, :create,:show,:verify,:login,:new_account_help,:create_account_help,:reset_password, :update_password]

  #Actions
  def index

  end

  def login #new
    @user = User.new
    render layout: 'simple'
  end

  def logout #new
    session[:user_id] = nil
    redirect_to users_login_path, :notice => "Logged out!"
  end

  def new_account_help #new
    @user = User.new
    render layout: 'simple'
  end

  def create_account_help #new
    email = params[:user][:email]
    @user = User.find_by(email: email)    
    if @user.present?
      flash[:notice] = "A reset link has been sent to your email please check email"
      UserMailer.forgot_email(@user).deliver_later
      render 'new_account_help'
    else
      render 'user_not_exist'
    end
  end

  def reset_password #new
    @user = User.find_by(id: params[:id])
  end

  def update_password #new
    @user = User.find_by(id: params[:id])
    @user.password = params["user"]["password"]
    if @user.save   #check please
      flash[:notice] = "Password Updated"
      redirect_to root_path
    end
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    @user.status_email = false
    if @user.save
      UserMailer.welcome_email(@user).deliver_later #VK : Need to put into template. done
      redirect_to  user_path(@user) # user k show par
    else
      render 'new'
    end
  end

  def verify
    @user = User.find_by(id: params["user_id"])
    @user.status_email = true
    if @user.save
      flash[:notice] = "Email successfully Verified"
      redirect_to root_path
    end
  end

  def edit
    @detail = @user.user_detail.present? ? @user.user_detail : @user.build_user_detail
  end

  def update
    @user = User.find_by(id: params[:id])    
    @detail = @user.user_detail.present? ? @user.user_detail : @user.build_user_detail
    # uploaded_io = params[:user][:user_detail_attributes][:avater]
    # uploaded_io.present? ? @user.size = uploaded_io.size : @user.size = 0
    # if uploaded_io.present?
    #   profile_pic_name = params[:user][:user_detail_attributes][:avater].original_filename
    #   File.open(Rails.root.join('public', 'uploads', profile_pic_name), 'wb') do |file|
    #   file.write(uploaded_io.read)
    #     @user.avater = profile_pic_name
    #   end
    # end
    @user.avatar = params[:user][:avatar].original_filename
    if @user.update(user_params)
      flash[:notice] = "#{@user.firstname} Your Profile successfully updated"
      redirect_to user_dashboards_path(user_id: @user.id) #VK : Redirect from here to dashboard and show message. remove "show_update" action. done
    else
      render 'edit'
    end
  end

  def friends
    @friends = @user.friends
  end

  def show
    render layout: "special_layout"
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :avatar, :email, :password, :gender, :dob, user_detail_attributes: [:address, :city, :pincode, :phone] )
    end

    # def details_params_up
    #   params.require(:user_detail).permit(:address, :city, :pincode, :phone)
    # end

    def session_activity
      if session[:user_id]
        redirect_to user_dashboards_path(user_id: session[:user_id])
      end
    end

    def compute_layout
      # ["new", :new,:create,:verify].include?(action_name)  ? "application" : "users" 
    end
end


