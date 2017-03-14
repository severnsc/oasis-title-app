FactoryGirl.define do
  factory :title_order do
    property
    buyer
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
    admin
  end

  factory :other_title_order, class: TitleOrder do
    property
    buyer
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
    non_admin
  end
end