FactoryGirl.define do
  factory :user, aliases: [:new_user] do
    sequence(:id, &:to_s)
    sequence(:email) { |n| "email#{n}@factory.com" }
    password '888888'
    password_confirmation '888888'
  end

  factory :other_user, parent: :user do
    password '999999'
    password_confirmation '999999'
  end
end
