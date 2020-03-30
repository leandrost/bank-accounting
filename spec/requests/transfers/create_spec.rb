# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /transfers', type: :request do
  subject(:post_create) do
    post(
      transfers_url,
      params: valid_params,
      headers: valid_headers,
      as: :json
    )
  end

  subject(:body) { JSON.parse(response.body) }

  let(:valid_params) do
    {
      data: {
        type: 'transfers',
        attributes: {
          source_account_id: account1.id,
          destination_account_id: account2.id,
          amount: '42,00'
        }
      }
    }
  end

  let(:valid_headers) { {} }

  let(:account1) { Account.create!(name: 'Account 1', balance: 1_000.42) }
  let(:account2) { Account.create!(name: 'Account 2') }

  it 'creates a new Transfer' do
    expect { post_create }.to change(Transfer, :count).by(1)
  end

  it 'renders a JSON response with the new resource' do
    post_create

    expect(response).to have_http_status(:created), response.body

    transfer = Transfer.last
    expect(body).to eq(
      'data' => {
        'id' => transfer.id.to_s,
        'type' => 'transfers',
        'attributes' => {
          'amount' => '42.0'
        },
        'relationships' => {
          'source-account-id' => {
            'data' => transfer.source_account_id
          },
          'destination-account-id' => {
            'data' => transfer.destination_account_id
          }
        }
      }
    )
  end

  it 'changes source_account and destination_account balances' do
    post_create

    transfer = Transfer.last
    expect(transfer.source_account.balance).to eq(958.42)
    expect(transfer.destination_account.balance).to eq(42)
  end
end