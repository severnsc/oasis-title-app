class StaticPagesController < ApplicationController
  before_action :logged_in, only: [:request_quote, :title_order]

	def home
	end

	def title_order
	end

	def request_quote
	end

  def about
  end

  def our_team
  end

  def our_role
  end

  def title_insurance
  end

  def real_estate_closings
  end

  def short_sale_services
  end

  def realtor_services
  end

  def lender_services
  end

  def homeowner_services
  end

  def closing_costs
  end

  def glossary
  end

  def title_faq
  end

  private

  def logged_in
    unless current_user
      store_location
      redirect_to login_path
    end
  end
end
