class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_sender
      t.text :tweet_text
      t.text :ticker
      t.datetime :tweet_sent

      t.timestamps null: false
    end
  end
end
