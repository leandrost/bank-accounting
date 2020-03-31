# frozen_string_literal: true

require 'rails_helper'

describe DepositFunds do
  describe '.run!' do
    subject(:run_service) do
      described_class.run!(account: account, amount: amount)
    end

    let(:account) { Account.new(balance: 200) }
    let(:amount) { 50 }

    before :each do
      allow(account).to receive(:save).and_return(true)
    end

    it 'adds amount from account balance' do
      run_service
      expect(account.balance).to eq 250
    end

    it 'saves account' do
      run_service
      expect(account).to have_received(:save)
    end
  end
end
