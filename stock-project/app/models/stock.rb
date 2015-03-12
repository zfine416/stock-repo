class Stock < ActiveRecord::Base
  has_many :fav_stocks
  has_many :tweets
  has_many :users, through: :fav_stocks
  validates :name, presence: true
  before_validation :get_data_from_yahoo

  def get_data_from_yahoo
    data = YahooFinance.quotes([ticker], [:name,:symbol])
    self.ticker= data[0].symbol.upcase
    self.name = data[0].name
    return true
  end

  def ticker=(new_ticker)
    self[:ticker] = new_ticker.upcase
  end
 
  def get_tweets
    consumer_key ||= OAuth::Consumer.new "LXJkKuXoRJzeyQzAx0TGoCZli", "yL3P69PF41OUObm2dPVFQujVKpxeNdtqwKMSAzSyHopA1VQOu4"
    access_token ||= OAuth::Token.new "3085560635-6gwFUx4pavCbblpFtlibvO4JYdFn6G5ugZk0nPi", "4AnySTXszbZOA9t74M0tIoH3Z0rbCvcsqnYwgz9VnQTg1"

    query = URI.encode_www_form("q" => '$'+ticker,"count" => 3)
    address = URI("https://api.twitter.com/1.1/search/tweets.json?#{query}")
    response = Net::HTTP::Get.new address
    # Set up HTTP.
    http             = Net::HTTP.new address.host, address.port
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Issue the request.
    request.oauth! http, consumer_key, access_token
    http.start
    response = http.request request
    JSON.parse(response.body).each do |tweet_hash|
      self.tweets << Tweet.new(tweet_sender: tweet_hash["user"]["screen_name"], tweet_text: tweet["text"], tweet_sent: tweet["created_at"])
    end
  end

end
