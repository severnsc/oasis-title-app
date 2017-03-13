class TitleOrdersController < ApplicationController
	before_action :logged_in
	before_action :correct_user, only: [:show, :edit, :update, :destroy]

	def new
		@title_order = TitleOrder.new
		@title_order.buyer_title_orders.build.build_buyer
	end

	def create
		@title_order = TitleOrder.new(title_order_params)
		@title_order.buyer_title_orders.build.build_buyer
		if @title_order.save
			flash[:success] = "title order created"
			redirect_to root_path
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
		params.require(:title_order).permit(:id, buyer_title_orders_attributes:[:id, buyer_attributes:[:id, :first_name, :last_name, :phone_number, :email]])
	end
end
