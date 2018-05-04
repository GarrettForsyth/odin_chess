FactoryBot.define do
  factory :user do
    sequence(:handle) { |n| "cool_handle#{n}" }
    sequence(:email) { |n| "cool_email#{n}@chess.com" }
    password Faker::Internet.password(6)
  end

  factory :confirmed_user, parent: :user do
    after(:create, &:confirm)
  end

  factory :seeklist do
    sequence(:name) { |n| "page_#{n}" }
  end

  factory :seek do
    timecontrol Random.rand(1..120)
    association :user, factory: :confirmed_user
    association :seeklist, factory: :seeklist
  end

  factory :invalid_seek, parent: :seek do
    timecontrol '-1'
  end

  factory :game do
    association :white_user, factory: :confirmed_user
    association :black_user, factory: :confirmed_user
    timecontrol Random.rand(1..120)
  end
end
