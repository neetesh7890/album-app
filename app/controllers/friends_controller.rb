class FriendsController < ApplicationController
	
	#Filters skip
	skip_before_action :access_check, only: [:notification,:accept,:show,:search,:destroy]

	#Actions
	def index
		@friends = @user.friends.confirm_friend
	end

	def show
		@friends = @user.friends.confirm_friend
	end

	def search
		@ids = @user.friends.confirm_friend.ids
		@ids = @ids.push(@user.id)
		@results = User.search(params[:q]).all_friends(@ids)
	end

	def notification
		@friend = User.find_by(id: params["friend_id"])
		@token = SecureRandom.uuid.gsub(/\-/,'')
		UserMailer.notification(@user, @friend, @token).deliver_later
		@userfriend = @user.user_friends.build(friend_id: @friend.id,token: @token,status: "pending")
		if @userfriend.save
			redirect_to user_dashboards_path(@user.id)
		else
			redirect_to user_dashboards_path(@user.id)
		end
	end

	def new
	end
	
	def accept
		@userfriend = UserFriend.find_by(token: params["token"])
		if @userfriend.status == "accept"
			flash[:notice] = "Already added"
		elsif @userfriend.token == params["token"] && @user.id == @userfriend.friend_id
			mutual =  @user.user_friends.build(token: @userfriend.token,friend_id: @userfriend.user_id, status: "accept")
			@userfriend.status = "accept"
			flash[:notice] = mutual.save && @userfriend.save ? "Friend Added" : "Could not added"
		else
			flash[:notice] = "Invalid Link"
			redirect_to user_dashboards_path(@user.id) and return
		end
		redirect_to user_dashboards_path(@user.id)
		# if @userfriend.token == params["token"] && session[:user_id]==@userfriend.friend_id
		# 	debugger
		# 	mutual =  @user.user_friends.build(token: @userfriend.token,friend_id: @userfriend.user_id, status: "accept")
		# 	if mutual.save
		# 		flash[:notice] = "Friend Added"
		# 	else
		# 		flash[:notice] = "Could not added"
		# 	end
		# end

		# if @userfriend.status == "accept"
		# 		flash[:notice] = "Already added"
		# 		redirect_to user_dashboards_path(user_id: @user.id)
		# else
		# 	if @userfriend.token == params["token"] && session[:user_id]==@userfriend.friend_id
		# 		@userfriend.status = "accept"
		# 		if  @userfriend.save
		# 			flash[:notice] = "Friend added"	
		# 			redirect_to user_dashboards_path(user_id: @user.id)
		# 		end
		# 	else
		# 		flash[:notice] = "Invalid Link"
		# 		redirect_to user_dashboards_path(user_id: @user.id)
		# 	end
		# end
	end

	def destroy
		friend = UserFriend.find_by("friend_id = ? AND user_id = ?",params[:id],params[:user_id])
		# friend_entries = @user.user_friends.where("friend_id = ?",params[:id])
		friend_entries = UserFriend.where(token: friend.token)
		friend_entries.destroy_all if friend_entries.present?
		redirect_to user_friends_path(@user.id) 
	end

	def edit
	end

	def update
	end

end
