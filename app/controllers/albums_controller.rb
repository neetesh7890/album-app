class AlbumsController < ApplicationController
	
	#Actions
	def index
		@albums = @user.albums.order('comment_count DESC').paginate(:page => params[:page], :per_page => 6)
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friends_albums = Album.where(user_id: user_ids).comments.paginate(:page => params[:page], :per_page => 6)
	end

	def my_album
		@albums = @user.albums
	end

	def friend_album
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friends_albums = Album.where(user_id: user_ids).comments
	end
	
	def my_album_all #new
		@album = @user.albums.find(params[:id])
		@albums = @album.album_images
		@albumimage = AlbumImage.new
	end

	def show
	end

	def new
		@album = Album.new
		@user = User.find_by(id: session[:user_id])
	end

	def create
		@album = @user.albums.new(params.require(:album).permit(:album_name))
		# img_names = params["album"]["image_name"]
		debugger
		album_image = @album.album_images.build 
		album_image.image_name = params[:album][:image_name].original_filename
		if @album.save		
			flash[:notice] = "Album Created"
			redirect_to user_albums_path(@user.id)	
		else
			redirect_to user_albums_path(@user.id)		
		end
		
		# if img_names.present?
			# img_names.each do |img_name|
			# 	@albumimage = @album.album_images.new
			# 	pic_name = img_name.original_filename
			# 	File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		 #      file.write(img_name.read)
		 #        @albumimage.image_name = pic_name
		 #      end
			# end

			# if @album.save
		# 		flash[:notice] = "Album Created"
		# 		redirect_to user_albums_path(@user.id)	
		# 	else
		# 		redirect_to user_albums_path(@user.id)		
		# 	end
		# else
		# 	flash[:notice] = "Album could not be created please select atleast one image"
		# 	redirect_to user_albums_path(@user.id)		
		# end
	end

	def edit
	end
	
	def update
		@album = @user.albums.find_by(id: params[:id])
		img_names = params["album"]["image_name"] if @album.present?
		unless img_names.nil?
			img_names.each do |img_name|
				@albumimage = AlbumImage.new
				@albumimage.album_id = @album.id
				pic_name = img_name.original_filename
				File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		      file.write(img_name.read)
				@albumimage.image_name = pic_name
		    end
				redirect_to album_all_user_album_path(@user.id,params[:id]) and return unless @albumimage.save	 #true par nahi chalega false par redirect to		        
				flash[:notice] = "Album Updated"
			end
		end

		redirect_to album_all_user_album_path(@user.id,params[:id])
	end

	def destroy	
		@album = @user.albums.find_by(id: params[:id])
		if @album.destroy
			flash[:notice] = "Album deleted"
			redirect_to user_albums_path(@user.id)
		else
			redirect_to user_albums_path(@user.id)
			flash[:notice] = "Album could not deleted"
		end
	end

	def destroy_pic #new
		@image = @user.albums.find_by(id: params[:id]).album_images.find_by(id: params[:pic_id])	
		if @image.destroy
			redirect_to album_all_user_album_path(@user.id,params[:id])
		else
			redirect_to album_all_user_album_path(@user.id,params[:id])
		end
	end

	#Private methods
	private
		def album_params
      params.require(:album).permit(:name,:album_name,:image_name)
    end
end
