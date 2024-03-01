# frozen_string_literal: true

class TransactionsController < ApplicationController
  def import_transactions
    ImportTransactionsService.call(
      params[:file].tempfile.path,
      params[:limit]
    )

    render json: { message: 'Transactions imported successfully' }, status: :ok
  end

  def check_transaction
    response = ProcessTransactionService.call(transaction_params)

    render json: response.to_json, status: :ok
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :transaction_id,
      :merchant_id,
      :user_id, :card_number,
      :transaction_date,
      :transaction_amount,
      :device_id
    )
  end
end
