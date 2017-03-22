require 'test_helper'

class SubmitTitleOrderTest < ActionDispatch::IntegrationTest

  def setup
    @user = create(:non_admin)
    @title_admin = create(:admin)
    @title_admin.update_column(:title_administrator, true)
    ActionMailer::Base.deliveries.clear
  end

  test "valid information" do
    log_in_as(@user)
    get new_title_order_path
    assert_template 'title_orders/new'
    assert_difference 'TitleOrder.count' do
      post title_orders_path, params: { title_order: { number_of_buyers: 1,
                                                        quote: false,
                                                        primary_residence: '1',
                                                        title_type: 'Single Man',
                                                        closing_type: "In Office",
                                                        buyers_agent_commission: '3%',
                                                        sellers_agent_commission: '3%',
                                                        survey_requested: false,
                                                        notes: 'Note',
                                                        property_attributes: { street: '21301 Powerline Rd',
                                                                    city: 'Boca Raton',
                                                                    state: "FL",
                                                                    zip: '33433'},
                                                        buyer_title_orders_attributes: {'0' => {buyer_attributes: { first_name: "Test",
                                                                                                              last_name: "Buyer",
                                                                                                              phone_number: "5555555555",
                                                                                                              email: 'user@test.com',
                                                                                                              mailing_address_attributes: { street: '21301 Powerline Rd',
                                                                                                                                  city: "Boca Raton",
                                                                                                                                  state: "FL",
                                                                                                                                  zip: "33433"}}}},
                                                        lender_attributes: { name: "Bank",
                                                                  phone_number: "561-123-4567",
                                                                  email: "lender@lender.com"},
                                                        buyers_agent_attributes: { first_name: "Larry",
                                                                        last_name: "Wesiberg",
                                                                        phone_number: "561-362-7355",
                                                                        email: "larry@test.com",
                                                                        license_number: "BK123456",
                                                                        brokerage_attributes: { name: "The Agency Luxe",
                                                                                      license_number: "BK123456",
                                                                                      address_attributes: { street: "366 E Palmetto Park Rd",
                                                                                                  city: "Boca Raton",
                                                                                                  state: "FL",
                                                                                                  zip: "33432"}}
                                                                                                  },
                                                        sellers_agent_attributes: { first_name: "Kevin",
                                                                          last_name: "Matthews",
                                                                          phone_number: "561-123-4567",
                                                                          email: "kevin@test.com",
                                                                          license_number: "BK123456",
                                                                          brokerage_attributes: { name: "The Agency Luxe",
                                                                                        license_number: "BK123456",
                                                                                        address_attributes: { street: "366 E Palmetto Park Rd",
                                                                                                    city: "Boca Raton",
                                                                                                    state: "FL",
                                                                                                    zip: "33432"}}}}}
    end
    order = assigns(:title_order)
    assert order.valid?, order.errors.full_messages.inspect
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_equal 1, @user.title_orders.count
    assert_includes @user.title_orders, order
    assert_not flash.empty?
    assert_redirected_to title_order_path(order)
  end
end