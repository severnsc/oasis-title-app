class UserMailer < ApplicationMailer

	def account_activation(user)
		@user = user
		mail to: @user.email, subject: "Account activation"
	end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Reset your password"
  end

  def admin_invite(user)
    @user = user
    mail to: @user.email, subject: "You have been invited to become an admin at Oasis Title Company"
  end
end
