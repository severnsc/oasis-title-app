FactoryGirl.define do
  factory :gallery, class: Bootsy::ImageGallery do
    id 1
    bootsy_resource_type "Post"
  end
end