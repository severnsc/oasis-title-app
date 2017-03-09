class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Please check your email for the activation link"
			redirect_to new_title_order_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end
