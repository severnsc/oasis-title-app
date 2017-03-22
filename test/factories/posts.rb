FactoryGirl.define do
  factory :post do
    title "Test Post"
    body "This is a test"
    user
    bootsy_image_gallery_id 1
  end
end
