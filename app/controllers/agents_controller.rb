class AgentsController < ApplicationController
  before_action :logged_in

  def show
  	@agent = Agent.find(params[:id])
  end

  private

  def logged_in
    redirect_to login_path unless current_user
  end
end
