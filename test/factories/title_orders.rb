FactoryGirl.define do
  factory :title_order do
    property
    buyers {build_list :buyer, 1}
    buyers_agent
    sellers_agent
    lender
    title_type 'Single Man'
    closing_type 'Mobile'
    buyers_agent_commission '3%'
    sellers_agent_commission '3%'
    survey_requested true
    notes 'This is a note'
    quote false
    user
  end

  factory :other_title_order, class: TitleOrder do
    association :property, factory: :address
    buyers {build_list :buyer, 1}
    buyers_agent
    sellers_agent
    lender
    title_type 'Single Man'
    closing_type 'Mobile'
    buyers_agent_commission '3%'
    sellers_agent_commission '3%'
    survey_requested true
    notes 'This is a note'
    quote false
    association :user, factory: :non_admin
  end
end