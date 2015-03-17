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
  stop_words_csv =   "i,me,my,myself,we,our,ours,ourselves,you,your,yours,yourself,yourselves,he,him,his,himself,she,her,hers,herself,it,its,itself,they,them,their,theirs,themselves,what,which,who,whom,this,that,these,those,am,is,are,was,were,be,been,being,have,has,had,having,do,does,did,doing,would,should,could,ought,i'm,you're,he's,she's,it's,we're,they're,i've,you've,we've,they've,i'd,you'd,he'd,she'd,we'd,they'd,i'll,you'll,he'll,she'll,we'll,they'll,isn't,aren't,wasn't,weren't,hasn't,haven't,hadn't,doesn't,don't,didn't,won't,wouldn't,shan't,shouldn't,can't,cannot,couldn't,mustn't,let's,that's,who's,what's,here's,there's,when's,where's,why's,how's,a,an,the,and,but,if,or,because,as,until,while,of,at,by,for,with,about,against,between,into,through,during,before,after,above,below,to,from,up,down,in,out,on,off,over,under,again,further,then,once,here,there,when,where,why,how,all,any,both,each,few,more,most,other,some,such,no,nor,not,only,own,same,so,than,too,very,also,tco"
  stopwords = stop_words_csv.split(",")
  stopwords << "http"
  stopwords << "https"
  name = @stock.name
  name_words = name.split(" ")
  # name_words.each |word| do
  #   stopwords << word
  # end

  stopwords << (@stock.ticker).to_s

  counts = Hash.new 0
  words = text.split(/\W+/)

  words.each do |word|
    word.downcase!
    counts[word] += 1 if (!stopwords.include? word)
  end


  # count and arrange words by frequency, find min and max
  words_by_freq = counts.sort_by {| key, value | -value }
  max_freq = words_by_freq.first
  min_freq = words_by_freq.last
  words_by_freq = words_by_freq.to_h

  # create hash with font-sizes for cloud
  max_font = 140
  min_font = 15
  @cloud = Hash.new 0

  words_by_freq.each do |word|
    weight = (word[1] - min_freq[1]).to_f / (max_freq[1] - min_freq[1])
    size = min_font + ( (max_font - min_font) * weight ).round
    @cloud[word[0]] = size
  end


 	respond_to do |format|
 		format.html
 		format.json {r
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
