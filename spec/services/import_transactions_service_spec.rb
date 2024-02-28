require 'rails_helper'

RSpec.describe ImportTransactionsService, type: :service do
  describe '#call' do
    let(:file_path) { 'spec/fixtures/files/transactional-sample.csv' }
    let(:limit) { 15 }

    subject { described_class.new(file_path, limit).call }

    it 'imports transactions' do
      expect { subject }.to change(Transaction, :count).by(2)
    end
  end
end
