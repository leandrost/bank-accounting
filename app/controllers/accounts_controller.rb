# frozen_string_literal: true

# Handle account resource requests
class AccountsController < ApplicationController
  before_action :set_account, only: %i[show update destroy]

  # GET /accounts
  def index
    render json: Account.all
  end

  # GET /accounts/1
  def show
    render json: account
  end

  # POST /accounts
  def create
    account = Account.new(account_params)

    if account.save
      render json: account, status: :created
    else
      render_json_errors_for(account)
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if account.update(account_params)
      render json: account
    else
      render_json_errors_for(account)
    end
  end

  # DELETE /accounts/1
  def destroy
    account.destroy
  end

  private

  attr_accessor :account

  def set_account
    self.account = Account.find(params[:id])
  end

  def account_params
    params.from_jsonapi.require(:account).permit(:name)
  end
end
