# frozen_string_literal: true

class TransactionsController < ApplicationController

  def index
    @transactions = Current.user.transactions.order(created_at: :desc)
  end

end
