# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of(:transaction_id) }
  it { should validate_presence_of(:merchant_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:card_number) }
  it { should validate_presence_of(:transaction_date) }
  it { should validate_presence_of(:transaction_amount) }
end
