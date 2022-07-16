FactoryBot.define do
  factory :user do
    name     { Faker::Name.name }
    email    { Faker::Internet.email }
    password { 'Password1' }

    trait :confirmed do
      confirmed_at       { Time.zone.now }
      confirmation_token { nil }
    end
  end
end
