# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  post 'import_transactions', to: 'transactions#import_transactions'
  post 'check_transaction', to: 'transactions#check_transaction'
end
