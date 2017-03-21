class BrokeragesController < ApplicationController
  before_action :logged_in

  def show
  	@brokerage = Brokerage.find(params[:id])
  end

  private

  def logged_in
    redirect_to login_path unless current_user
  end
end
