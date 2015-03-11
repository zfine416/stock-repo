class StocksController < ApplicationController

  def show
    @stock = Stock.find(params[:stock_ticker])
  end

end
