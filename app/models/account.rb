# frozen_string_literal: true

# Represents a user bank account
class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
