class CommentsController < ApplicationController
	
	#Actions
	def index
		@album = @user.albums.find_by(id: params[:album_id])
		@albums = @album.album_images
		@comment = Comment.new
		@comments = @album.comments
		@friend = User.find_by(id: @album.user_id)
	end

	def album_comments #new
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friends_albums = Album.where(user_id: user_ids).comments
		@album = @friends_albums.find_by(id: params[:album_id])
		@albums = @album.album_images
		@comment = Comment.new
		@comments = @album.comments
		@friend = User.find_by(id: @album.user_id)
	end

	def new
		@album = Album.find_by(id: params[:album_id])
		@friend = User.find_by(id: @album.user_id)
		@albums = @album.album_images
		@comment = Comment.new
		if @album.comments.present?
			redirect_to album_comment_path(@album.id, @album.comments[0].id) and return
		else
			#Its correct code
		end 
	end

	def create
	end

	def remark
		@album = Album.find_by(id: params[:album_id])
		@comment = @album.comments.create(params.require(:comment).permit(:comment_name))
		id_store = Comment.find_by(id: @comment.id)
		id_store.user_id = @user.id
		Album.find_by(id: params[:album_id]).increment!(:comment_count) #Auto increment comment_count in albums
		if id_store.save
			redirect_to user_album_comments_path(@user.id,params[:album_id])
		else
			flash[:notice] = "Comments wan not done"
			redirect_to user_album_comments_path(@user.id,params[:album_id])	# params[:id] send does not maek sense but to make routes valid
		end
	end

	def comments_remark
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friends_albums = Album.where(user_id: user_ids).comments
		@album = @friends_albums.find_by(id: params[:album_id])
		@comment = @album.comments.create(params.require(:comment).permit(:comment_name))
		id_store = Comment.find_by(id: @comment.id)
		id_store.user_id = @user.id
		Album.find_by(id: params[:album_id]).increment!(:comment_count) #Auto increment comment_count in albums
		if id_store.save
			redirect_to comments_user_album_comments_path(@user.id,params[:album_id])
		else
			flash[:notice] = "Comments wan not done"
			redirect_to comments_user_album_comments_path(@user.id,params[:album_id])	# params[:id] send does not maek sense but to make routes valid
		end
	end

	def show	
	end

	def destroy	
		comment = @user.albums.find_by(id: params[:album_id]).comments.find(params[:id])
		Album.find_by(id: params[:album_id]).decrement!(:comment_count) #Auto decrement comment_count in albums
		if comment.destroy
			redirect_to user_album_comments_path(@user.id,params[:album_id])
		else
			flash[:notice] = "Something went wrong could not delete comment"
			redirect_to user_album_comments_path(@user.id,params[:album_id])
		end
	end

	def comment_destroy #new
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friends_albums = Album.where(user_id: user_ids).comments
		comment = @friends_albums.find_by(id: params[:album_id]).comments.find(params[:id])
		Album.find_by(id: params[:album_id]).decrement!(:comment_count) #Auto decrement comment_count in albums
		if comment.destroy
			redirect_to comments_user_album_comments_path(@user.id,params[:album_id])
		else
			flash[:notice] = "Something went wrong could not delete comment"
			redirect_to comments_user_album_comments_path(@user.id,params[:album_id])
		end
	end

	def edit 
	end

	def update
	end

end
