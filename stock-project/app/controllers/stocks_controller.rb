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

  # generate text from tweet contents
  text = " "
  @tweets.each do |tweet|
    text << tweet.tweet_text
  end

  # generate word list from block of text
  counts = Hash.new 0
  words = text.split(/\W+/)

  words.each do |word|
    word.downcase!
    counts[word] += 1 if (word.length > 2 && word != (
     @stock.ticker || "the" || "and" || "http"))
  end

  # count and arrange words by frequency, find min and max
  words_by_freq = counts.sort_by {| key, value | -value }
  max_freq = words_by_freq.first
  min_freq = words_by_freq.last
  words_by_freq = words_by_freq.to_h

  # create hash with font-sizes for cloud
  max_font = 100
  min_font = 5
  @cloud = Hash.new 0

  words_by_freq.each do |word|
    weight = (word[1] - min_freq[1]).to_f / (max_freq[1] - min_freq[1])
    size = min_font + ( (max_font - min_font) * weight ).round
    @cloud[word[0]] = size
  end


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

  #  Pry.start(binding)
 end
end
