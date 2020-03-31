# frozen_string_literal: true

# Takes the specified amount from account balance
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
