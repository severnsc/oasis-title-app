FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :admin, aliases: [:user], class: User do
    email
    name "Chris Severns"
    password_digest {User.digest('password')}
    admin true
    activated true
    activated_at {Time.zone.now}
  end

  factory :non_admin, aliases: [:user2], class: User do
    email
    name "Non-admin"
    password_digest {User.digest('password')}
    admin false
    activated true
    activated_at {Time.zone.now}
  end
end