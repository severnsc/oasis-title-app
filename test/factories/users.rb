FactoryGirl.define do
  factory :admin, class: User do
    id 1
    email "user@example.com"
    name "Chris Severns"
    password_digest {User.digest('password')}
    admin true
    activated true
    activated_at {Time.zone.now}
  end

  factory :non_admin, class: User do
    id 2
    email "user2@example.com"
    name "Non-admin"
    password_digest {User.digest('password')}
    admin false
    activated true
    activated_at {Time.zone.now}
  end
end