# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction do
  it { is_expected.to validate_presence_of(:transaction_id) }
  it { is_expected.to validate_presence_of(:merchant_id) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:card_number) }
  it { is_expected.to validate_presence_of(:transaction_date) }
  it { is_expected.to validate_presence_of(:transaction_amount) }
end
