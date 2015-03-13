class StocksController < ApplicationController

  def show
    @stock = Stock.find(params[:stock_ticker])
  end

  # <form "/stocks" method="POST">
  #  Symbol: <input type="text" name="stock[symbol]" />
      # <input type="submit">
  # </form>

  def create
    @stock = Stock.find_or_initialize_by(symbol: params[:stock][:symbol])
    @stock.get_data_from_yahoo
  end

end
