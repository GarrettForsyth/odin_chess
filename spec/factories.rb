FactoryBot.define do
  factory :user do
    sequence(:handle) { |n| "TestUser#{n}" }
    sequence(:email) { |n| "test#{n}@email.com" }
    password 'secret'

    after(:create, &:confirm)
  end
end
