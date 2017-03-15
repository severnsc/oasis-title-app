class TitleOrdersController < ApplicationController
	before_action :logged_in
	before_action :correct_user, only: [:show, :edit, :update, :destroy]

	def new
		@title_order = TitleOrder.new
		params[:number_of_buyers] ? session[:number_of_buyers] = params[:number_of_buyers].to_i : session[:number_of_buyers] = 1
		session[:number_of_buyers].times {@title_order.buyer_title_orders.build.build_buyer.build_mailing_address}
		@title_order.build_property
		@title_order.build_lender
		@title_order.build_buyers_agent.build_brokerage.build_address
		@title_order.build_sellers_agent.build_brokerage.build_address
	end

	def create
		@title_order = TitleOrder.new(title_order_params)
		@title_order.buyer_title_orders.each_with_index do |bto, i| 
			bto.build_buyer(title_order_params['buyer_title_orders_attributes']["#{i}"]['buyer_attributes'])
		end
		if params[:primary_residence] == '1'
			@title_order.buyer_title_orders.each do |bto|
				bto.buyer.address = @title_order.property
			end
		else
			@title_order.buyer_title_orders.each do |bto|
				bto.buyer.address = bto.buyer.mailing_address
			end
		end
		@title_order.user = current_user
		@title_order.marry_buyers if params[:married] == '1'
		if @title_order.save
			current_user.title_orders << @title_order
			current_user.save
			flash[:success] = "title order created"
			session.delete(:number_of_buyers)
			redirect_to title_order_path(@title_order)
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
		if @title_order.update_attributes(title_order_params)
			flash[:success] = "Title order updated!"
			redirect_to title_order_path(@title_order)
			session.delete(:number_of_buyers)
		else
			render 'edit'
		end
	end

	def index
		current_user.admin? ? @title_orders = TitleOrder.all : @title_orders = current_user.title_orders
	end

	def destroy
		@title_order = TitleOrder.find(params[:id])
		@title_order.delete
		redirect_to current_user
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
		params.require(:title_order).permit(:id, 
			:number_of_buyers,
			:quote,
			:primary_residence,
		  :title_type,
		  :closing_type,
		  :buyers_agent_commission,
		  :sellers_agent_commission,
		  :survey_requested,
		  :notes,
			property_attributes: [:street, :city, :state, :zip],
			buyer_title_orders_attributes: [:id, buyer_attributes: [:id, :first_name, :last_name, :phone_number, :email, mailing_address_attributes: [:street, :city, :state, :zip]]],
		  lender_attributes: [:name, :phone_number, :email],
		  buyers_agent_attributes: [:first_name, :last_name, :phone_number, :email, :license_number, brokerage_attributes: [:name, :license_number, address_attributes: [:street, :city, :state, :zip]]],
		  sellers_agent_attributes: [:first_name, :last_name, :phone_number, :email, :license_number, brokerage_attributes: [:name, :license_number, address_attributes: [:street, :city, :state, :zip]]])
	end
end
