class PasswordResetController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      if @user.activated
        @user.create_password_reset_digest
        @user.send_password_reset_email
        flash[:notice] = "Password reset instructions sent to your email."
        redirect_to root_path
      else
        flash[:notice] = "Your account is not activated! Look in your email for the activation link."
      end
    else
      flash.now[:danger] = "No account found with that email!"
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    if @user.update_attributes(password_params)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password updated! Please login."
      redirect_to login_path
    else
      render 'edit'
    end
  end

  private

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired!"
      redirect_to new_password_reset_url
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
