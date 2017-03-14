FactoryGirl.define do
  factory :address do
    street '366 E Palmetto Park Rd'
    city 'Boca Raton'
    state 'FL'
    zip '33432'
  end

  factory :property, class: Address do
    street '21301 Powerline Rd'
    city 'Boca Raton'
    state 'FL'
    zip '33433'
  end

  factory :mailing_address, class: Address do
    street '123 N Street'
    city 'Fake City'
    state 'FL'
    zip '33433'
  end
end