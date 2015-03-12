class StocksController < ApplicationController
  # before_action :require_current_user#, only: :index
  # before_action :user_is_current_user#, only: [:index, :new, :create]

  def show
    @stock = Stock.find(params[:stock_ticker])
  end

  def create
    @stock = Stock.find_or_initialize_by(ticker: params[:ticker].upcase)
    binding.pry
    @stock.save
  end
end
