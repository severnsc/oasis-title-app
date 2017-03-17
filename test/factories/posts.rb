FactoryGirl.define do
  factory :post do
    title "Test Post"
    body "This is a test"
    user
  end
end
