FactoryGirl.define do
  factory :agent, aliases: [:buyers_agent, :sellers_agent] do
    first_name "Larry"
    last_name "Weisberg"
    phone_number '5615412225'
    email 'larry@example.com'
    license_number "BK123456"
    brokerage
  end
end