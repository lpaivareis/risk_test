# frozen_string_literal: true

class Transaction < ApplicationRecord
  validates :transaction_id, :merchant_id,
            :user_id, :card_number, :transaction_date,
            :transaction_amount, presence: true
end
