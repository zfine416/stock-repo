class FavStock < ActiveRecord::Base
	belongs_to :user
	belongs_to :stocks
end
