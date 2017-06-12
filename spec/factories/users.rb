# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@factory.com" }
    password '888888'
    password_confirmation '888888'
  end
end
