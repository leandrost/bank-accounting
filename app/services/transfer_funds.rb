# frozen_string_literal: true

# Transfers amount from one account to another
class TransferFunds < ApplicationService
  attribute :destination_account_id, :integer
  attribute :source_account_id, :amount
  attribute :amount, :amount

  def execute
    withdrawal = WithdrawFunds.run!(account: source_account, amount: amount)
    return failure(transfer, withdrawal.result) if withdrawal.failure?

    transfer.destination_account.balance += transfer.amount
    transfer.destination_account.save!

    transfer.save

    transfer
  end

  def transfer
    @transfer ||= Transfer.new(
      source_account: source_account,
      destination_account: destination_account,
      amount: amount
    )
  end

  def failure(transfer, service_result)
    transfer.errors.merge!(service_result.errors)
    transfer
  end

  def source_account
    @source_account ||= Account.find(source_account_id)
  end

  def destination_account
    @destination_account ||= Account.find(destination_account_id)
  end
end
