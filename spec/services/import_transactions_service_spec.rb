# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportTransactionsService, type: :service do
  describe '#call' do
    subject(:service) { described_class.new(file_path, limit).call }

    let(:file_path) { 'spec/fixtures/files/transactional-sample.csv' }
    let(:limit) { 15 }

    it 'imports transactions' do
      expect { service }.to change(Transaction, :count).by(15)
    end
  end
end
