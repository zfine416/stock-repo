class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all

  end

  def tweets_for_current_user

    stock = Stock.find(params[:stock_id])
