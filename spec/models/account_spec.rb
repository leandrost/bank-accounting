# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
end
