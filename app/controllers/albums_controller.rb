class AlbumsController < ApplicationController

	def index

		@user = User.find_by(id: session[:user_id])
		@albums = @user.albums.paginate(:page => params[:page], :per_page => 6).order('comment_count DESC')
		@album_ids = @user.friends.joins(:albums).paginate(:page => params[:page], :per_page => 6).album_has_more_comments
	end

	def my_album
    @user = User.find_by(id: session[:user_id])
		@albums = @user.albums.order('comment_count DESC')
	end

	def friend_album
		@album_ids = @user.friends.joins(:albums).album_has_more_comments
	end
	
	def show
		@album = @user.albums.find(params[:id])
		@albums = @album.album_images
		@albumimage = AlbumImage.new
	end

	def new
		@album = Album.new
	end

	def edit
	end
	
	def update
		@album = Album.find_by(id: params[:id])
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
				redirect_to albums_path and return unless @albumimage.save	 #true par nahi chalega false par redirect to
				flash[:notice] = "Album Updated"
			end
		end

		redirect_to albums_path
	end

	def create
		# @album = Album.new(params.require(:album).permit(:album_name))
		# @user = User.find_by(id: session[:user_id])
		# @album.user_id = @user.id

		@album = @user.albums.new(params.require(:album).permit(:album_name))

		img_names = params["album"]["image_name"]
		if img_names.present?
			if @album.save
				img_names.each do |img_name|
					@albumimage = AlbumImage.new
					@albumimage.album_id = @album.id
					pic_name = img_name.original_filename
					File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
			      file.write(img_name.read)
			        @albumimage.image_name = pic_name
			      end
					@albumimage.save	
				end
				flash[:notice] = "Album Created"
				redirect_to my_album_path(id: @user.id)	
			end	
		else
			flash[:notice] = "Album could not be created please select atleast one image"
			redirect_to my_album_path(id: @user.id)		
		end

		# unless arr.nil?
		# 	arr.each do |img_name|
		# 		@albumimage = AlbumImage.new
		# 		@albumimage.album_id = @album.id
		# 		pic_name = img_name.original_filename
		# 		File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		#       file.write(img_name.read)
		#         @albumimage.image_name = pic_name
		#       end
		# 		@albumimage.save	
		# 	end
		# end
	end

	def destroy	
		@image = AlbumImage.find_by(id: params[:id])
		album = Album.find_by(id: @image.album_id)	
		if @image.destroy
			redirect_to album_path(id: album.id)
		else
			redirect_to album_path(id: album.id)
		end
	end

	def destroy_album
		@album = Album.find_by(id: params[:album_id])
		@album.destroy  #check error if come
		flash[:notice] = "Album Deleted"
		redirect_to my_album_path(id: session[:user_id])
	end

	private
		def album_params
      params.require(:album).permit(:name,:album_name,:image_name)
    end
end
