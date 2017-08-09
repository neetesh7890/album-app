class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def forgot_email(user)
    @user = user
    email_with_name = %("#{@user.firstname}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Reset Password')
  end

	def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.firstname}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Welcome User')
  end

  def notification(user,friend,token)
    @user = user
    @friend = friend
    @token = token
    email_with_name = %("#{@friend.firstname}" <#{@friend.email}>)
    mail(to: email_with_name, subject: 'New Request')
  end
end