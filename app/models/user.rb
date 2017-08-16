class User < ApplicationRecord
  validates :firstname, presence: true
  validates :email, uniqueness: true, presence: true,format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, presence: true
  validates :gender, presence: true
  validates :dob, presence: true
  
  # validate :avater_size

  has_one :user_detail
  has_many :albums
  
  has_many :user_friends
  has_many :friends, through: :user_friends

  scope :confirm_friend, ->{ where("user_friends.status ='accept'") }
  scope :pending_friend, ->{ where("user_friends.status ='pending'") }# how to merge these two lines into one

  # scope :album_has_more_comments, ->{ select('albums.id').where("user_friends.status='accept'").order('comment_count DESC') }
  # scope :not_friend, ->{ where("user_friends.status <>'accept'") }
  scope :all_friends, -> (ids) { where.not(id: ids) }
  

  def self.search(search)
    if search.present?
      where('firstname LIKE ?', "%#{search}%")
    else
      all
    end
  end

  # after_initialize do |user|
  #   puts "You have initialized an object!"
  # end

  # after_find do |user|
  #   puts "You have found an object!"
  # end

	def self.authenticate(emailath, password)
    user = User.find_by(email: emailath)
    #VK : Optimize below code and reduce below conditions. done
    if user.status_email && user.present? && password == user.password
      user    
    else
      user = nil 
    end

    # unless @user.status_email #if status false then 
    #   @user.
    #   flash[:notice] = "Please Verify email first"
    #   redirect_to root_path
    # end

   #if nil then return nil
   #  if @user.nil?
   #    pass = nil
   #    email = nil
   #  else
  	#   pass = @user.password
  	#   email = @user.email
   #  end
  	# if pass==password && email==emailath && @user.status_email
  	# 	@user
  	# else
  	# 	@user = nil
  	# end
  end

  private 
    def avater_image_size
      if avater.size > 5.megabytes
        errors.add(:avater, "should be less than 5MB" )
      end
    end

end
