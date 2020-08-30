# frozen_string_literal: true

FactoryBot.define do
  factory :available_seat do
    label { Faker::App.name }
    row { Faker::Number.number(digits: 2) }
    column { Faker::Number.number(digits: 2) }
    venue
  end
end
