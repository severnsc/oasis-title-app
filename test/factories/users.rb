FactoryGirl.define do
  factory :admin, class: User do
    email "admin@example.com"
    name "Chris Severns"
    password_digest {User.digest('password')}
    admin true
    activated true
    activated_at {Time.zone.now}
  end

  factory :non_admin, class: User do
    email "non-admin@example.com"
    name "Non-admin"
    password_digest {User.digest('password')}
    admin false
    activated true
    activated_at {Time.zone.now}
  end
end