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
  stop_words_csv =   "i,me,my,myself,we,our,ours,ourselves,you,your,yours,yourself,yourselves,he,him,his,himself,she,her,hers,herself,it,its,itself,they,them,their,theirs,themselves,what,which,who,whom,this,that,these,those,am,is,are,was,were,be,been,being,have,has,had,having,do,does,did,doing,would,should,could,ought,i'm,you're,he's,she's,it's,we're,they're,i've,you've,we've,they've,i'd,you'd,he'd,she'd,we'd,they'd,i'll,you'll,he'll,she'll,we'll,they'll,isn't,aren't,wasn't,weren't,hasn't,haven't,hadn't,doesn't,don't,didn't,won't,wouldn't,shan't,shouldn't,can't,cannot,couldn't,mustn't,let's,that's,who's,what's,here's,there's,when's,where's,why's,how's,a,an,the,and,but,if,or,because,as,until,while,of,at,by,for,with,about,against,between,into,through,during,before,after,above,below,to,from,up,down,in,out,on,off,over,under,again,further,then,once,here,there,when,where,why,how,all,any,both,each,few,more,most,other,some,such,no,nor,not,only,own,same,so,than,too,very,also,tco,http,https,via,one,vs.,stock,updated"
  stopwords = stop_words_csv.split(",")
  name = @stock.name.split
  name.each do |word|
    word = word.downcase!
    # word.gsub!(/[^0-9A-Za-z]/, '')
  end
  ticker = @stock.ticker.downcase

  counts = Hash.new 0
  hashtags = Hash.new 0
  related = Hash.new 0
  mentioned = Hash.new 0


  words = text.split

  words.each do |word|
    if word.start_with? "#"
      hashtags[word] += 1
    elsif (word.start_with? "$") && !(word.downcase.include? ticker)
      related[word] += 1
    elsif word.start_with? "@"
      mentioned[word] += 1
    else
      word.gsub!(/[^0-9A-Za-z]/, '')
      word.downcase!
      counts[word] += 1 if (
      (!stopwords.include? word)  &&
      (!name.include? word) &&
      (word.length > 2) &&
      !(word.include? "http") &&
      !(word.include? ticker) &&
      (word.to_i == 0)
      )
    end
  end

  # count and arrange words by frequency, find min and max
  words_by_freq = counts.sort_by {| key, value | -value }
  words_by_freq = words_by_freq.take(200)
  max_freq = words_by_freq.first
  min_freq = words_by_freq.last
  words_by_freq = words_by_freq.to_h
  puts words_by_freq.count

  # create hash with font-sizes for cloud
  max_font = 100
  min_font = 15
  @cloud = Hash.new 0

  words_by_freq.each do |word|
    weight = (word[1] - min_freq[1]).to_f / (max_freq[1] - min_freq[1])
    size = min_font + ( (max_font - min_font) * weight ).round
    @cloud[word[0]] = size
  end

  @cloud = @cloud.to_a
  @cloud.shuffle!
  @cloud = @cloud.to_h




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
