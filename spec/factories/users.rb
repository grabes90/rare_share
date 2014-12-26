FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@example.com" }

  factory :user do
    first_name "John"
    last_name "Doe"
    email
    password "please123"
  end
end
