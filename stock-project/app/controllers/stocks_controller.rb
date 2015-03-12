class StocksController < ApplicationController
  # before_action :require_current_user#, only: :index
  # before_action :user_is_current_user#, only: [:index, :new, :create]

  # def show
  #   @stock = Stock.find(params[:stock_ticker])
  # end

  def create
    Pry.start(binding)
    # @stock = Stock.find_or_initialize_by(symbol: params[:stock][:symbol])
    # @stock.get_data_from_yahoo
  end
end
