class TweetsController < ApplicationController

  def tweets_for_current_user
    @stocks = Stock.find(params[:user_id])
    @stocks.each do |stock|
      tweet = Tweet.find(params[:stock_id])
    end
  end

end
