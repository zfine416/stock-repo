class Stock < ActiveRecord::Base
  before_create :get_data_from_yahoo

  def get_data_from_yahoo
    response = Net::HTTP.get "http://finance.yahoo.com/?token=#{asdf}&symbol=#{symbol}"
    response_json = JSON.parse(response)
    self.name = response_json["name"]
  end

  has_many :fav_stocks
  has_many :tweets
  has_many :users, through: :fav_stocks
end
