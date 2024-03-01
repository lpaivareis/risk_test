# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    transaction_id { Faker::Number.number(digits: 6) }
    merchant_id { Faker::Number.number(digits: 6) }
    user_id { Faker::Number.number(digits: 6) }
    card_number { Faker::Number.number(digits: 16).to_s }
    transaction_date { Time.zone.now }
    transaction_amount { 100 }
    device_id { Faker::Number.number(digits: 6) }
    has_cbk { false }
  end

  trait :with_cbk do
    has_cbk { true }
  end

  trait :high_amount do
    transaction_amount { 2000 }
  end
end
