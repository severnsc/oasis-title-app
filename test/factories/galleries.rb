FactoryGirl.define do
  factory :gallery, class: Bootsy::ImageGallery do
    bootsy_resource_type "Post"
  end
end