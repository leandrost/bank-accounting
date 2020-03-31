# frozen_string_literal: true

# Adds the specified amount from account balance
class DepositFunds < ApplicationService
  attribute :account
  attribute :amount, :amount

  def execute
    account.balance += amount
    account.save
    account
  end
end
