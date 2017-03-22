FactoryGirl.define do
  factory :buyer do
    first_name "Chris"
    last_name "Severns"
    phone_number "8888888888"
    email 'user@example.com'
    mailing_address
  end
end