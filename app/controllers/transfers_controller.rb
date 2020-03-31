# frozen_string_literal: true

class TransfersController < ApplicationController
  # GET /transfers
  def index
    transfers = Transfer.all

    render json: transfers
  end

  # GET /transfers/1
  def show
    transfer = Transfer.find(params[:id])
    render json: transfer
  end

  # POST /transfers
  def create
    operation = TransferFunds.run!(transfer_params)

    if operation.success?
      render json: operation.result, status: :created
    else
      render_json_errors_for(operation.result)
    end
  end

  private

  def transfer_params
    params.from_jsonapi.require(:transfer).permit(
      :source_account_id,
      :destination_account_id,
      :amount
    )
  end
end
