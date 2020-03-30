# frozen_string_literal: true

class TransferSerializer < ActiveModel::Serializer
  attributes :id, :amount

  has_one :source_account_id
  has_one :destination_account_id
end
