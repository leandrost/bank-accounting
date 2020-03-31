# frozen_string_literal: true

# Exchanges an amount from one account to another
class WithdrawFunds < ApplicationService
  attribute :account
  attribute :amount, :amount

  def execute
    if insufficient_funds?
      account.errors.add(:base, 'insufficient funds')
      return account
    end

    account.balance -= amount
    account.save
    account
  end

  def insufficient_funds?
    amount > account.balance
  end
end
