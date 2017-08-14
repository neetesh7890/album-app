class FriendsController < ApplicationController
	
	skip_before_action :access_check, only: [:index,:notification,:accept,:show,:search,:destroy]
	


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
		
		@userfriend = UserFriend.new
		@userfriend.user_id = @user.id
		@userfriend.friend_id = @friend.id
		@userfriend.token = @token
		@userfriend.status = "pending"	
		
		if @userfriend.save
			redirect_to user_dashboards_path(user_id: @user.id) #remove redirect
		else	
			redirect_to user_dashboards_path(user_id: @user.id) #remove redirect
		end
	end

	def new
	end
	
	def accept
		@userfriend = UserFriend.find_by(token: params["token"])
		
		if @userfriend.token == params["token"] && session[:user_id]==@userfriend.friend_id
			mutual = UserFriend.new
			mutual.token = @userfriend.token
			mutual.user_id = @userfriend.friend_id
			mutual.friend_id = @userfriend.user_id
			mutual.status = "accept"
		
			if mutual.save
				flash[:notice] = "Friend Added"
			else
				flash[:notice] = "Could not added"
			end
		end

		if @userfriend.status == "accept"
				flash[:notice] = "Already added"
				redirect_to user_dashboards_path(user_id: @user.id)
		else
			if @userfriend.token == params["token"] && session[:user_id]==@userfriend.friend_id
				@userfriend.status = "accept"
				if  @userfriend.save
					flash[:notice] = "Friend added"	
					redirect_to user_dashboards_path(user_id: @user.id)
				end
			else
				flash[:notice] = "Invalid Link"
				redirect_to user_dashboards_path(user_id: @user.id)
			end
		end
	end

	def destroy
		debugger
		@friend = @user.friends.confirm_friend.find(params[:id])
		friend_entries = UserFriend.where(token: @friend.token)
		friend_entries.each do |entry|
			entry.destroy
		end	
		redirect_to friend_path(id: session[:user_id]) 
	end

	def edit
	end

	def update
	end

end
