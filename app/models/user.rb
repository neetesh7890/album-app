class User < ApplicationRecord
  
  #Validations
  validates :firstname, presence: true
  validates :email, uniqueness: true, presence: true,format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :password, presence: true
  validates :gender, presence: true
  validates :dob, presence: true
  validate :avatar_size , if: :avatar?

  #Attributes
  attr_accessor :size, :avatar
  
  #Associations
  has_one :user_detail, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :user_friends, dependent: :destroy, inverse_of: :user
  has_many :friends, through: :user_friends

  accepts_nested_attributes_for :user_detail

  #Scopes
  scope :confirm_friend, ->{ where("user_friends.status ='accept'") }
  scope :pending_friend, ->{ where("user_friends.status ='pending'") }# how to merge these two lines into one
  scope :all_friends, -> (ids) { where.not(id: ids) }
  # scope :album_has_more_comments, ->{ select('albums.id').where("user_friends.status='accept'").order('comment_count DESC') }
  # scope :not_friend, ->{ where("user_friends.status <>'accept'") }
  
  #Uploader
  mount_uploader :avatar, AvatarUploader

  #Public Class Methods
  def self.search(search)
    if search.present?
      where('firstname LIKE ?', "%#{search}%")
    else
      all
    end
  end

  def self.authenticate(emailath, password)
    user = User.find_by(email: emailath)
    #VK : Optimize below code and reduce below conditions. done
    if user.present? && password == user.password && user.status_email
      user
    else
      nil
    end
  end

  #Public methods
  def avatar_size #VK : Need to put into common place and understand how to use it into multiple models.
    errors.add(:base, "Image should be less than 5MB") if size > 5.megabytes
  end 

  # def self.i_user(image_object)
  #   debugger
  #   if image_object.present?
  #     a = AvatarUploader.new
  #     a.small?(image_object)
  #     debugger
  #   else
  #     debugger
  #   end
  # end

  # after_initialize do |user|
  #   puts "You have initialized an object!"
  # end

  # after_find do |user|
  #   puts "You have found an object!"
  # end   
end
