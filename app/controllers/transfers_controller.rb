# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[show update destroy]

  # GET /transfers
  def index
    @transfers = Transfer.all

    render json: @transfers
  end

  # GET /transfers/1
  def show
    render json: @transfer
  end

  # POST /transfers
  def create
    operation = CreateTransfer.run!(transfer_params)

    if operation.success?
      render json: operation.result, status: :created
    else
      render_json_errors_for(operation.result)
    end
  end

  # PATCH/PUT /transfers/1
  def update
    if @transfer.update(transfer_params)
      render json: @transfer
    else
      render json: @transfer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transfers/1
  def destroy
    @transfer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def transfer_params
    params.from_jsonapi.require(:transfer).permit(
      :source_account_id,
      :destination_account_id,
      :amount
    )
  end
end
