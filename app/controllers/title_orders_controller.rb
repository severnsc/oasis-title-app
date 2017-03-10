class TitleOrdersController < ApplicationController
	before_action :logged_in
	before_action :correct_user, only: [:show, :edit, :update, :destroy]

	def new
		@title_order = current_user.title_orders.build
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
		@title_order = current_user.title_orders.build(title_order_params)
		@title_order.check_if_params_exist
		@title_order.buyers.each do |buyer|
			buyer.address = @title_order.property if params[:primary_residence] = '1'
		end
		@title_order.sellers_agent.brokerage = @title_order.buyers_agent.brokerage if @title_order.buyers_agent.brokerage.license_number == @title_order.sellers_agent.brokerage.license_number
		@title_order.marry_buyers if params[:married] == '1'
		@title_order.quote = true if params[:quote] == '1'
		if @title_order.save
			flash[:success] = "Title order created!"
			redirect_to title_order_path(@title_order)
			session.delete(:number_of_buyers)
		else
			render 'new'
		end
	end

	def show
		@title_order = TitleOrder.find(params[:id])
	end

	def edit
		@title_order = TitleOrder.find(params[:id])
		session[:number_of_buyers] = @title_order.buyers.count
	end

	def update
		@title_order = TitleOrder.find(params[:id])
		@title_order.buyers.each do |buyer|
			buyer.address = @title_order.property if params[:primary_residence] = '1'
		end
		#byebug
		if @title_order.update_attributes(title_order_params)
			flash[:success] = "Title order updated!"
			redirect_to title_order_path(@title_order)
			session.delete(:number_of_buyers)
		else
			render 'edit'
		end
	end

	def index
		@title_orders = TitleOrder.all
	end

	def destroy
		@title_order = TitleOrder.find(params[:id])
		@title_order.delete
		redirect_to new_title_order_path
	end

	private

	def logged_in
		redirect_to root_path unless logged_in?
	end

	def correct_user
		@title_order = TitleOrder.find(params[:id])
		@user = @title_order.user
		redirect_to root_path unless current_user?(@user) || current_user.admin?
	end

	def title_order_params
		params.require(:title_order).permit(:number_of_buyers, :title_type, :closing_type, :sellers_agent_commission, :buyers_agent_commission, :survey_requested, :notes, buyers_attributes: [:id, :first_name, :last_name, :phone_number, :email, mailing_address_attributes: [:street, :city, :state, :zip]], property_attributes: [:id, :street, :city, :state, :zip], lender_attributes: [:id, :name, :phone_number, :email], buyers_agent_attributes: [:id, :first_name, :last_name, :license_number, :phone_number, :email, brokerage_attributes: [:id, :name, :license_number, address_attributes: [:id, :street, :city, :state, :zip]]], sellers_agent_attributes: [:id, :first_name, :last_name, :license_number, :phone_number, :email, brokerage_attributes: [:id, :name, :license_number, address_attributes:[:id, :street, :city, :state, :zip]]])
	end
end
