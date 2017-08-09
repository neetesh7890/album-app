class CommentsController < ApplicationController
	def index
	end

	def new
		@user = User.find_by(id: session[:user_id])
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
		@user = User.find_by(id: session[:user_id])
		@album = Album.find_by(id: params[:album_id])
		@comment = @album.comments.create(params.require(:comment).permit(:comment_name))
		id_store = Comment.find_by(id: @comment.id)
		id_store.user_id = @user.id
		if id_store.save
			redirect_to album_comment_path(@album.id, @comment.id)	# params[:id] send does not maek sense but to make routes valid
		else
			redirect_to album_comment_path(@album.id, @comment.id)	# params[:id] send does not maek sense but to make routes valid
		end
	end

	def show
		@user = User.find_by(id: session[:user_id])
		@album = Album.find_by(id: params[:album_id])
		@friend = User.find_by(id: @album.user_id)
		@albums = @album.album_images
		@comment = Comment.new
		@comments = @album.comments
		
	end

	def destroy
		# session check karke khud ka comment delete only check please
		comment = Comment.find_by(id: params[:id])
		if comment.user_id == session[:user_id] 
			comment.destroy
			redirect_to album_comment_path(params[:album_id],params[:id]) # params[:id] send does not maek sense but to make routes valid 		else 
		else
			flash[:notice] = "You can not delete friend's comment."
			redirect_to album_comment_path(params[:album_id],params[:id]) # params[:id] send does not maek sense but to make routes valid 
		end
	end

	def edit 
	end

	def update
	end

end
