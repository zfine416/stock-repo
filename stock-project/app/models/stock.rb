class Stock < ActiveRecord::Base
  has_many :fav_stocks
  has_many :tweets
  has_many :users, :through :fav_stocks
end
