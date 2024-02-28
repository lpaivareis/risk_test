# frozen_string_literal: true
require 'csv'

class ImportTransactionsService < ApplicationService
  attr_reader :file_path, :limit

  def initialize(file_path, limit = nil)
    @file_path = file_path
    @limit = limit
  end

  def call
    import_transactions
  end

  private

  def import_transactions

    rows = CSV.read(file_path, headers: true)
    rows = rows.take(limit.to_i) if limit

    data = rows.map do |row|
      transaction_data(row)
    end

    create_transactions(data)
  end

  def create_transactions(data)
    Transaction.insert_all(data)
  end

  def transaction_data(row)
    {
      transaction_id: row['transaction_id'],
      merchant_id: row['merchant_id'],
      user_id: row['user_id'],
      card_number: row['card_number'],
      transaction_date: row['transaction_date'],
      transaction_amount: row['transaction_amount'],
      has_cbk: row['has_cbk']
    }
  end
end
