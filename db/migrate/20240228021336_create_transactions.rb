# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_id
      t.integer :merchant_id
      t.integer :user_id
      t.string :card_number
      t.timestamp :transaction_date
      t.integer :transaction_amount
      t.integer :device_id
      t.boolean :has_cbk, default: false, null: false

      t.timestamps
    end
  end
end
