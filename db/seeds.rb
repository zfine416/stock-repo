# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Stock.delete_all

Stock.create({
	ticker: "GOOG",
	name: "Google",
	earnings_per_share: "12",
	pe_ratio: "1.2",
	last_trade_price: "554.42",
	volume: "14873921",
	average_daily_volume: "3214",
	change_in_percent: "1.42%"

	})


Tweet.delete_all

Tweet.create({
	tweet_sender: "alphatweet",
	tweet_text: "Rumor has it GE is in talks to acquire TSLA",
	ticker: "GOOG",
	tweet_sent: "2015-03-10"
	})
