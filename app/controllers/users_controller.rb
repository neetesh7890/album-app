class UsersController < ApplicationController
  layout :compute_layout
  skip_before_action :access_check, only: [:new, :create,:show,:verify]
  before_action :session_activity, only:[:new]
  
  def index
  end

  def new
    @user = User.new 
    render layout: "special_layout" # Don't render a layout
  end

  def create
    @user = User.new(user_params)
    @user.status_email = false
    if @user.save 
      UserMailer.welcome_email(@user).deliver_later #VK : Need to put into template. done
      redirect_to  user_path(@user) # user k show par
    else
      redirect_to new_user_path
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
    @user = User.find_by(id: session[:user_id])
    @detail = @user.user_detail.present? ? @user.user_detail : UserDetail.new
  end

  def update  
    @user = User.find_by(id: params[:id])
    @detail = @user.user_detail.present? ? @user.user_detail : UserDetail.new(details_params_up)
    uploaded_io = params[:user_detail][:avater]
    bool = true
    bool = avater_size(uploaded_io.size) if uploaded_io.present?
    if uploaded_io.present? && bool
      profile_pic_name = params[:user_detail][:avater].original_filename
      File.open(Rails.root.join('public', 'uploads', profile_pic_name), 'wb') do |file|
      file.write(uploaded_io.read)
        @user.avater = profile_pic_name
        @detail.user_id = @user.id
      end
    else
      flash[:notice] = "Profile did not update error occured on form or image size might be too large "
      redirect_to dashboards_path and return
    end  

    if @detail.update(details_params_up) && @user.save
      flash[:notice] = "#{@user.firstname} Your Profile successfully updated"
      redirect_to dashboards_path #VK : Redirect from here to dashboard and show message. remove "show_update" action. done
    else
      render 'edit'
    end
  end

  def friends
    @user = User.find_by(id: session[:user_id])
    @friends = @user.friends
  end

  def show
    render layout: "special_layout"
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :gender, :dob)
    end

    def details_params_up
      params.require(:user_detail).permit(:address, :city, :pincode, :phone)
    end

    def session_activity
      if session[:user_id]
        redirect_to dashboards_path
      end
    end

    def compute_layout
      # ["new", :new,:create,:verify].include?(action_name)  ? "application" : "users" 
    end

    def avater_size(size) #VK : Need to put into common place and understand how to use it into multiple models.
      if  size > 5.megabytes #Need to understand how you can get the size of image.
        false
      else
        true
      end
    end

end


