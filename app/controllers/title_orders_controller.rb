class TitleOrdersController < ApplicationController

	def new
		@title_order = TitleOrder.new
		@title_order.build_buyers_agent
		@title_order.build_sellers_agent
		@title_order.buyers_agent.build_brokerage
		@title_order.sellers_agent.build_brokerage
		@title_order.buyers_agent.brokerage.build_address
		@title_order.sellers_agent.brokerage.build_address
		@title_order.build_property
		@title_order.build_lender
		params[:number_of_buyers] ? session[:number_of_buyers] = params[:number_of_buyers].to_i : session[:number_of_buyers] = 1
	end

	def create
		@title_order = TitleOrder.new(title_order_params)
		@title_order.check_if_params_exist
		@title_order.buyers.each do |buyer|
			buyer.address = @title_order.property if params[:primary_residence] = '1'
		end
		@title_order.sellers_agent.brokerage = @title_order.buyers_agent.brokerage if @title_order.buyers_agent.brokerage.license_number == @title_order.sellers_agent.brokerage.license_number
		@title_order.check_if_married
		if @title_order.save
			flash[:success] = "Title order created!"
			redirect_to title_order_path(@title_order)
			session.delete(:number_of_buyers)
		else
			render 'new'
		end
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

	private

	def title_order_params
		params.require(:title_order).permit(:number_of_buyers, :title_type, :closing_type, :sellers_agent_commission, :buyers_agent_commission, :survey_requested, buyers_attributes: [:first_name, :last_name, :phone_number, :email], property_attributes: [:street, :city, :state, :zip], lender_attributes: [:name, :phone_number, :email], buyers_agent_attributes: [:first_name, :last_name, :license_number, :phone_number, :email, brokerage_attributes: [:name, :license_number, address_attributes: [:street, :city, :state, :zip]]], sellers_agent_attributes: [:first_name, :last_name, :license_number, :phone_number, :email, brokerage_attributes: [:name, :license_number, address_attributes:[:street, :city, :state, :zip]]])
	end
end
