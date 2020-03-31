require "rails_helper"

describe WithdrawFunds do
  describe ".run!" do
    subject(:run_service) { described_class.run!(account: account, amount: amount) }

    let(:account) { Account.new(balance: 200) }
    let(:amount) { 50 }

    before :each do
      allow(account).to receive(:save).and_return(true)
    end

    it 'debits amount from account balance' do
      run_service
      expect(account.balance).to eq 150
    end

    it 'saves account' do
      run_service
      expect(account).to have_received(:save)
    end

    context 'when balance is less than amount' do
      let(:account) { Account.new(balance: 200) }
      let(:amount) { 450 }

      it 'does not changes balance' do
        run_service
        expect(account.balance).to eq 200
      end
    end
  end
end

