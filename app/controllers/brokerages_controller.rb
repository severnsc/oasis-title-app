class BrokeragesController < ApplicationController
  before_action :logged_in

  def show
  	@brokerage = Brokerage.find(params[:id])
  end

  private

  def logged_in
    unless current_user
      store_location
      redirect_to login_path
    end
  end
end
