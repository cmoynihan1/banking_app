# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :validate_user, only: [:create]


  def index
    @transactions = Current.user.transactions.order(created_at: :desc)
  end

  def new
    redirect_to '/transactions' unless %w[deposit withdrawal transfer].include? params[:type]
    @transaction = Transaction.new(transaction_type: params[:type])
  end

  def create
    Transaction.transaction do
      case transaction_params[:transaction_type]
      when 'deposit'
        @transaction = Current.user.incoming_transactions.new(transaction_params)
        @transaction_amount = @transaction.amount
      when 'transfer', 'withdrawal'
        @transaction = Current.user.outgoing_transactions.new(transaction_params)
        @transaction_amount = -@transaction.amount
        if transaction_params[:transaction_type] == 'transfer'
          @recipient = User.find_by!(username: params[:recipient])
          @transaction.to_account = @recipient
        end
      else
        raise "Incorrect Type"
      end

      update_balances
      @transaction.save!
      redirect_to '/transactions'
    end
  rescue => error
    ::Rails.logger.info error
    redirect_to '/transactions'
  end


  private

  def update_balances
    Current.user.update!(balance: Current.user.balance + @transaction_amount)
    @recipient.update!(balance: @recipient.reload.balance + (-@transaction_amount)) if @recipient
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :transaction_type)
  end

  def validate_user
    raise Error 'Invalid user' if params[:username] != Current.user.username
  end

end
