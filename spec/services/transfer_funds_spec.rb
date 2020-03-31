# frozen_string_literal: true

require 'rails_helper'

describe TransferFunds do
  describe '.run!' do
    subject(:run_service) do
      described_class.run!(
        source_account_id: account1.id,
        destination_account_id: account2.id,
        amount: amount
      )
    end

    let(:account1) { Account.new(id: 42, balance: 200) }
    let(:account2) { Account.new(id: 24, balance: 100) }
    let(:amount) { 150 }

    before :each do
      allow(Account).to receive(:find_by)
        .with(id: account1.id)
        .and_return(account1)

      allow(Account).to receive(:find_by)
        .with(id: account2.id)
        .and_return(account2)

      service = instance_double(
        WithdrawFunds,
        success?: true,
        failure?: false,
        result: account1
      )
      allow(WithdrawFunds).to receive(:run!).and_return(service)

      service = instance_double(
        DepositFunds,
        success?: true,
        failure?: false,
        result: account2
      )
      allow(DepositFunds).to receive(:run!).and_return(service)

      allow_any_instance_of(Transfer).to receive(:save!).and_return(true)
    end

    it 'withdrawls amount from source account' do
      run_service

      expect(WithdrawFunds).to have_received(:run!).with(
        account: account1,
        amount: amount
      )
    end

    it 'makes a deposit of specified amount into destination account' do
      run_service

      expect(DepositFunds).to have_received(:run!).with(
        account: account2,
        amount: amount
      )
    end

    it 'returns a transfer' do
      expect(run_service.result).to be_a(Transfer)
      expect(run_service.result).to have_attributes(
        source_account: account1,
        destination_account: account2,
        amount: amount
      )
    end
  end
end
