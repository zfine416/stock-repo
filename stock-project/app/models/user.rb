class User < ActiveRecord::Base
	has_secure_password
	validates :email, presence: true
	has_many :fav_stocks
	has_many :favorites, through: :fav_stocks, source: :stock
end
