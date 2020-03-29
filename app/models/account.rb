# frozen_string_literal: true

# Represents a user bank account
class Account < ApplicationRecord
  validates :name, presence: true
end
