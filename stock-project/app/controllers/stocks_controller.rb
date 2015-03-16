class StocksController < ApplicationController
 # before_action :require_current_user#, only: :index
 # before_action :user_is_current_user#, only: [:index, :new, :create]

 def create
 	@stock = Stock.find_or_initialize_by(ticker: params[:ticker].upcase)
 	@stock.save unless @stock.persisted?
 	redirect_to "/stocks/#{@stock.ticker}"
 end

 def favorite
  @stock = Stock.find_by(ticker: params[:ticker])  
 	current_user.favorites << @stock
 	redirect_to :back, notice: "You favored #{@stock.name}"
 end

 def unfavorite
  @stock = Stock.find_by(ticker: params[:ticker])  
  current_user.fav_stocks.find_by(stock_id: @stock.id).destroy
  redirect_to :back, notice: "Unfavored #{@stock.name}"
 end


 def show
 	@stock = Stock.find_by(ticker: params[:ticker])
 	@tweets = Tweet.where("ticker" => @stock.ticker)
   # binding.pry
 end
end
