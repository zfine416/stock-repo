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
 	@stock.get_data_from_yahoo
 	@stock.save! if @stock.changed?
 	@tweets = Tweet.where("ticker" => @stock.ticker)
 	respond_to do |format|
 		format.html
 		format.json { 
 			render json: {
 				id: @stock.id,
 				ticker: @stock.ticker,
 				earnings_per_share: @stock.earnings_per_share,
 				pe_ratio: @stock.pe_ratio,
 				last_trade_price: @stock.last_trade_price,
 				volume: @stock.volume,
 				average_daily_volume: @stock.average_daily_volume,
 				change_in_percent: @stock.change_in_percent
 			}
 		}
 	end
 end
end
