class CommentsController < ApplicationController
	
	#Filters skip
	skip_before_action :verify_authenticity_token, :only => [:remark]

	#Filters
	before_action :get_album, only: [:remark, :comments_remark,:index]	

	#Actions
	def index
		# @album = @user.albums.find_by(id: params[:album_id])
		@comment = Comment.new
		@friend = User.find_by(id: @album.user_id)
	end

	def remark
		# @album = Album.find_by(id: params[:album_id])
		@comment = @album.comments.build(comment_name: params[:new_comment], user_id: @user.id)
		@album.increment!(:comment_count) #Auto increment comment_count in albums
		# if @comment.save
		# 	redirect_to user_album_comments_path(@user.id,params[:album_id])
		# else
		# 	flash[:notice] = "Comments wan not done"
		# 	redirect_to user_album_comments_path(@user.id,params[:album_id])	# params[:id] send does not maek sense but to make routes valid
		# end
		@comment.save
		respond_to do |format|
			format.js
		end
	end

	def destroy	
		# @comment = @user.albums.find_by(id: params[:album_id]).comments.find(params[:id])
		@comment = Comment.find(params[:id])
		Album.find_by(id: params[:album_id]).decrement!(:comment_count) #Auto decrement comment_count in albums
		@comment = @comment.destroy
		respond_to do |format|
			format.js
		end
		# if comment.destroy
			# render 'index'
			# redirect_to user_album_comments_path(@user.id,params[:album_id])
		# else
			# render 'index'
			# flash[:notice] = "Something went wrong could not delete comment"
			# redirect_to user_album_comments_path(@user.id,params[:album_id])
		# end
	end

	# def comments_remark
	# 	# @friends_albums = Album.where(user_id: @user.friends.confirm_friend.pluck(:id)).comments
	# 	# @album = @friends_albums.find_by(id: params[:album_id])
	# 	# @comment = @album.comments.build(comment_name: params[:comment][:comment_name])
	# 	# @comment.user_id = @user.id
	# 	# Album.find_by(id: params[:album_id]).increment!(:comment_count) #Auto increment comment_count in albums
	# 	@comment = @album.comments.build(comment_name: params[:comment][:comment_name], user_id: @user.id)
	# 	if @comment.save
	# 		redirect_to comments_user_album_comments_path(@user.id, params[:album_id])
	# 	else
	# 		flash[:notice] = "Comments wan not done"
	# 		redirect_to comments_user_album_comments_path(@user.id, params[:album_id])	# params[:id] send does not maek sense but to make routes valid
	# 	end
	# end

	def album_comments
		# @friends_albums = Album.where(user_id: @user.friends.confirm_friend.pluck(:id)).comments
		# @album = @friends_albums.find_by(id: params[:album_id])
		# @albums = @album.album_images
		# @comment = Comment.new
		# @comments = @album.comments
		# @friend = User.find_by(id: @album.user_id)
	end

	def new
		# @album = Album.find_by(id: params[:album_id])
		# @friend = User.find_by(id: @album.user_id)
		# @albums = @album.album_images
		# @comment = Comment.new
		# if @album.comments.present?
		# 	redirect_to album_comment_path(@album.id, @album.comments[0].id) and return
		# else
		# 	#Its correct code
		# end 
	end

	def create
	end

	
	def show	
	end

	# def comment_destroy #new
	# 	@friends_albums = Album.where(user_id: @user.friends.confirm_friend.pluck(:id)).comments
	# 	comment = @friends_albums.find_by(id: params[:album_id]).comments.find(params[:id])
	# 	Album.find_by(id: params[:album_id]).decrement!(:comment_count) #Auto decrement comment_count in albums
	# 	if comment.destroy
	# 		redirect_to comments_user_album_comments_path(@user.id,params[:album_id])
	# 	else
	# 		flash[:notice] = "Something went wrong could not delete comment"
	# 		redirect_to comments_user_album_comments_path(@user.id,params[:album_id])
	# 	end
	# end

	def edit 
	end

	def update
	end


	private
		def get_album
			@album = Album.find_by(id: params[:album_id])
		end
end
