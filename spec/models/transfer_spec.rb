require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { should validate_presence_of(:source_account) }
  it { should validate_presence_of(:destination_account) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount).is_greater_than(0) }
end
