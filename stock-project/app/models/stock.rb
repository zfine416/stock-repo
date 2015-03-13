class Stock < ActiveRecord::Base
  has_many :fav_stocks
  has_many :tweets
  has_many :users, through: :fav_stocks
  validates :name, presence: true
  before_validation :get_data_from_yahoo
  before_validation :get_tweets

  def get_data_from_yahoo
    data = YahooFinance.quotes([ticker], [:name, :symbol, :earnings_per_share, :pe_ratio, :last_trade_price, :volume, :average_daily_volume, :change_in_percent])
    self.ticker= data[0].symbol.upcase
    self.name = data[0].name
    self.earnings_per_share = data[0].earnings_per_share
    self.pe_ratio = data[0].pe_ratio
    self.last_trade_price = data[0].last_trade_price
    self.volume = data[0].volume
    self.average_daily_volume = data[0].average_daily_volume
    self.change_in_percent = data[0].change_in_percent
    return true
  end

  def ticker=(new_ticker)
    self[:ticker] = new_ticker.upcase
  end



  def get_tweets
    # Create query
    baseurl = "https://api.twitter.com"
    path    = "/1.1/search/tweets.json"
    query = URI.encode_www_form("q" => "$#{self.ticker}", "count" => 7)

    address = URI("#{baseurl}#{path}?#{query}")
    request = Net::HTTP::Get.new address.request_uri

    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    consumer_key ||= OAuth::Consumer.new "LXJkKuXoRJzeyQzAx0TGoCZli", "yL3P69PF41OUObm2dPVFQujVKpxeNdtqwKMSAzSyHopA1VQOu4"
    access_token ||= OAuth::Token.new "3085560635-6gwFUx4pavCbblpFtlibvO4JYdFn6G5ugZk0nPi", "4AnySTXszbZOA9t74M0tIoH3Z0rbCvcsqnYwgz9VnQTg1"

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request

    # Method to create Tweet objects
    def cache_tweets(tweets)
      tweets["statuses"].each do |tweet|
        new_tweet = Tweet.new
        new_tweet.tweet_sender = tweet["user"]["screen_name"]
        new_tweet.tweet_text = tweet["text"]
        new_tweet.ticker = self.ticker
        new_tweet.tweet_sent = tweet["created_at"]
        new_tweet.save
      end
    end

    # Parse and print the Tweet if the response code was 200
    tweets = nil
    if response.code == '200' then
      tweets = JSON.parse(response.body)
      cache_tweets(tweets)
    end
    nil

    # binding.pry

  end



end
