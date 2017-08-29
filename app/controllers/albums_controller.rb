class AlbumsController < ApplicationController
	
	#Actions
	def index
		@albums = @user.albums.order('comment_count DESC').paginate(:page => params[:page], :per_page => 5)
		user_ids = @user.friends.confirm_friend.ids
		@friends_albums = Album.where(user_id: user_ids).albums_order_by_comments.paginate(:page => params[:page], :per_page => 5)
	end

	def my_album
	end

	def friend_album
		user_ids = @user.friends.confirm_friend.pluck(:id)
		@friend_albums = Album.where(user_id: user_ids).albums_order_by_comments
	end
	
	def my_album_all
		@album = @user.albums.find(params[:id])
		@albumimage = AlbumImage.new
	end

	def destroy_pic
		@image = @user.albums.find_by(id: params[:id]).album_images.find_by(id: params[:pic_id])	
		if @image.destroy
			redirect_to album_all_user_album_path(@user.id,params[:id])
		else
			redirect_to album_all_user_album_path(@user.id,params[:id])
		end
	end

	def show
	end

	def new
		@album = Album.new
		@album_image = @album.album_images.build
	end

	def create
		@album = @user.albums.new(params.require(:album).permit(:album_name))
		images = params["album"]["image_name"]
		if images.present?
			images.each do |image|
				@album_image = @album.album_images.build
				@album_image.image_name = image
			end			
			if @album.save
				flash[:notice] = "Album Created"
				redirect_to user_albums_path(@user.id)	
			else
				redirect_to user_albums_path(@user.id)		
			end
		else
			flash[:notice] = "Album could not uploaded please select atleat one image"
			redirect_to user_albums_path(@user.id)	
		end

		# img_names = params["album"]["image_name"]
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
		if img_names.present?
			img_names.each do |image|
				album_image = @album.album_images.build
				album_image.image_name = image		
			end
			if @album.save
				redirect_to album_all_user_album_path(@user.id,params[:id])
			end
		else
			flash[:notice] = "Album could not update"
			redirect_to album_all_user_album_path(@user.id,params[:id])	
		end
		# unless img_names.nil?
		# 	img_names.each do |img_name|
		# 		@albumimage = AlbumImage.new
		# 		@albumimage.album_id = @album.id
		# 		pic_name = img_name.original_filename
		# 		File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		#       file.write(img_name.read)
		# 		@albumimage.image_name = pic_name
		#     end
		# 		redirect_to album_all_user_album_path(@user.id,params[:id]) and return unless @albumimage.save	 #true par nahi chalega false par redirect to		        
		# 		flash[:notice] = "Album Updated"
		# 	end
		# end
	end

	def destroy	
		@album = @user.albums.find_by(id: params[:id])
		if @album.destroy
			flash[:notice] = "Album deleted"
			redirect_to user_albums_path(@user.id)
		else
			flash[:notice] = "Album could not deleted"
			redirect_to user_albums_path(@user.id)
		end
	end

	

	#Private methods
	private
		def album_params
      params.require(:album).permit(:name,:album_name,:image_name)
    end
end
