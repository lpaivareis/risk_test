# frozen_string_literal: true

class ProcessTransactionService < ApplicationService
  attr_reader :transaction_params

  def initialize(transaction_params)
    super()
    @transaction_params = transaction_params
  end

  def call
    verify_fraud

    response
  end

  private

  def find_or_create
    Transaction.find_or_create_by(transaction_params)
  end

  def verify_fraud
    Fraud::VerifyFraudService.call(find_or_create)
  end

  def response
    {
      transaction_id: find_or_create.transaction_id,
      recommendation: verify_fraud
    }
  end
end
