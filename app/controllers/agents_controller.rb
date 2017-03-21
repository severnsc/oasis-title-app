class AgentsController < ApplicationController
  before_action :logged_in

  def show
  	@agent = Agent.find(params[:id])
  end

  private

  def logged_in
    unless current_user
      store_location
      redirect_to login_path
    end
  end
end
