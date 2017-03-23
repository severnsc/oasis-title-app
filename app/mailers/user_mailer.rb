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

  def admin_alert(user, invitee)
    @user = user
    @invitee = invitee
    mail to: @user.email, subject: "A new admin invite has been sent out"
  end

  def title_alert(user, title_order)
    @user = user
    @title_order = title_order
    mail to: @user.email, subject: "New title order submitted!"
  end

  def admin_accept(user, admin)
    @user = user
    @admin = admin
    mail to: @user.email, subject: "New admin added!"
  end
end
