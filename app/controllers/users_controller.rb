class UsersController < ApplicationController
	before_action :logged_in_user, only: [:show, :admin, :admin_invite]
	before_action :is_admin?, only: [:admin, :admin_invite]
	before_action :correct_user, only: [:edit, :update, :admin, :admin_invite]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:info] = "Please check your email for the activation link"
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated!"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def index
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		if @user == current_user
			log_out
			@user.delete
			redirect_to root_path
		else
			@user.delete
			flash[:success] = "User deleted!"
			redirect_to current_user
		end
	end

	def admin
		@user = User.find(params[:id])
	end

	def admin_invite
		@invitee = User.find_by_email(params[:admin_invite][:email])
		if @invitee
			if @invitee.activated?
				@invitee.create_admin_invite_digest
				@invitee.save
				@invitee.send_admin_invite_email
				flash[:success] = "Admin invite sent!"
				redirect_to admin_path(current_user)
			else
				flash[:notice] = "That account is not activated!"
				redirect_to admin_path(current_user)
			end
		else
			flash.now[:danger] = "No user found with that email!"
			render 'admin'
		end
	end

	def edit_admin_status
		user = User.find_by_email(params[:email])
		if user && user.activated? && user.authenticated?(:admin, params[:id]) && user.update_attribute(:admin, true)
			user.update_attribute(:admin_digest, nil)
			log_in(user)
			flash[:success] = "You are now an admin!"
			redirect_to admin_path(user)
		else
			flash[:danger] = "Invalid link!"
			redirect_to root_path
		end
	end

	private

	def logged_in_user
		unless current_user
			store_location
			redirect_to login_path
		end
	end

	def is_admin?
		redirect_to current_user unless current_user && current_user.admin?
	end

	def correct_user
		user = User.find(params[:id])
		redirect_to current_user unless user == current_user
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :password_confirmation)
	end
end
