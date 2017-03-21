class SearchesController < ApplicationController
  before_action :logged_in
  before_action :correct_user, only:[:show, :update]

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @search.user = current_user
    if @search.save 
      redirect_to search_path(@search) 
    else
      render 'new'
    end
  end

  def show
    @search = Search.find(params[:id])
    if @search.order_type = 'Quote'
      @title_orders = @search.title_orders.where('quote = ?', true)
    else
      @title_orders = @search.title_orders.where('quote = ?', false)
    end
  end

  def update
    @search = Search.find(params[:id])
    if @search.update_attributes(search_params)
      flash[:success] = "Search saved!"
      redirect_to search_path(@search)
    else
      flash[:danger] = "Invalid name! Search not saved!"
      redirect_to search_path(@search)
    end
  end

  private

  def search_params
    params.require(:search).permit(:search_name, :buyer_name, :street, :city, :state, :zip)
  end

  def logged_in
    redirect_to root_path unless current_user
  end

  def correct_user
    @search = Search.find(params[:id])
    user = @search.user
    redirect_to root_path unless user == current_user
  end
end
