# frozen_string_literal: true

# Exchanges an amount from one account to another
# TODO: spec
class CreateTransfer
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :result

  attribute :destination_account_id, :integer
  attribute :source_account_id, :amount
  attribute :amount, :amount

  def self.run!(args)
    operation = new(args)
    operation.tap(&:run)
  end

  def run
    self.result = execute
  end

  def execute
    transfer = Transfer.new(attributes)
    transfer.save

    transfer.source_account.balance -= transfer.amount
    transfer.source_account.save!

    transfer.destination_account.balance += transfer.amount
    transfer.destination_account.save!

    transfer
  end

  def success?
    result.errors.blank?
  end
end
