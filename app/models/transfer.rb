# frozen_string_literal: true

# Represent a bank account transfert between two accounts
class Transfer < ApplicationRecord
  belongs_to :source_account, class_name: 'Account'
  belongs_to :destination_account, class_name: 'Account'

  validates :source_account, :destination_account, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
