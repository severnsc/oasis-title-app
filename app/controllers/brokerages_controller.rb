class BrokeragesController < ApplicationController
  def show
  	@brokerage = Brokerage.find(params[:id])
  end
end
