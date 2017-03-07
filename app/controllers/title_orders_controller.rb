class TitleOrdersController < ApplicationController

	def new
		@title_order = TitleOrder.new
		@title_order.build_buyers_agent
		@title_order.build_sellers_agent
		@title_order.build_property
		@title_order.build_lender
		params[:number_of_buyers] ? @number_of_buyers = params[:number_of_buyers].to_i : @number_of_buyers = 1
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def index
	end

	def delete
	end
end
