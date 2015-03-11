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
	name: "Google"
	})

Stock.create({
	ticker: "PEP",
	name: "Pepsi"
	})

Stock.create({
	ticker: "GE",
	name: "General Electric"
	})

Tweet.delete_all

Tweet.create({
	tweet_sender: "alphatweet",
	tweet_text: "Rumor has it GE is in talks to acquire TSLA",
	tweet_sent: 2015-03-10
	})

Tweet.create({
	tweet_sender: "betatweet",
	tweet_text: "Long PEP now!!!",
	tweet_sent: 2015-03-11
	})
