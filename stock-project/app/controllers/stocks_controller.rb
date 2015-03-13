class StocksController < ApplicationController
  # before_action :require_current_user#, only: :index
  # before_action :user_is_current_user#, only: [:index, :new, :create]

  def create
    @stock = Stock.find_or_initialize_by(ticker: params[:ticker].upcase)
    @stock.save
    redirect_to "/stocks/#{@stock.ticker}"
  end


  def show
    @stock = Stock.find_by(ticker: params[:ticker])
    # binding.pry
  end
end
