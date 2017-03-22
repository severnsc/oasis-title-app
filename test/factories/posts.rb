FactoryGirl.define do
  factory :post do
    title "Test Post"
    body "This is a test"
    user
    status "published"
    association :bootsy_image_gallery, factory: :gallery
  end

  factory :unpublished, class: 'Post' do
    title "Unpublished"
    body "Not published"
    user
    status "draft"
    association :bootsy_image_gallery, factory: :gallery
  end
end
