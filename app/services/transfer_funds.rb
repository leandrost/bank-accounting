# frozen_string_literal: true

# Transfers amount from one account to another
class TransferFunds < ApplicationService
  attribute :destination_account_id, :integer
  attribute :source_account_id, :amount
  attribute :amount, :amount

  def execute
    return transfer if account_errors?

    ActiveRecord::Base.transaction do
      compose(WithdrawFunds, account: source_account, amount: amount)
      compose(DepositFunds, account: destination_account, amount: amount)

      transfer.save!
    end
    transfer
  end

  private

  def account_errors?
    add_account_error(:source_account_id) if source_account.blank?
    add_account_error(:destination_account_id) if destination_account.blank?

    transfer.errors.present?
  end

  def add_account_error(attr_name)
    transfer.errors.add(attr_name, 'account not found')
  end

  def transfer
    @transfer ||= Transfer.new(
      source_account: source_account,
      destination_account: destination_account,
      amount: amount
    )
  end

  def compose(service_klass, **args)
    service = service_klass.run!(args)

    if service.failure?
      transfer.errors.merge!(service.result.errors)
      raise ActiveRecord::Rollback
    end

    service.result
  end

  def source_account
    @source_account ||= Account.find_by(id: source_account_id)
  end

  def destination_account
    @destination_account ||= Account.find_by(id: destination_account_id)
  end
end
