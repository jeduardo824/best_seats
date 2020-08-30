# frozen_string_literal: true

FactoryBot.define do
  factory :venue do
    title { Faker::App.name }
    rows { Faker::Number.number(digits: 2) }
    columns { Faker::Number.number(digits: 2) }
  end
end
