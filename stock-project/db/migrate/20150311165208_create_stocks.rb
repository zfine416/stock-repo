class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.string :earnings_per_share
      t.string :pe_ratio
      t.string :last_trade_price
      t.string :volume
      t.string :average_daily_volume
      t.string :change_in_percent

      t.timestamps null: false
    end
  end
end
