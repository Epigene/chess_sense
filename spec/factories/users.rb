FactoryBot.define do
  factory :user do
    sequence(:email, 1) { |n| "user#{n}@example.com" }
    password "test_password"
    name "John Doe"
    data({})
  end
end
