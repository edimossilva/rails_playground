# frozen_string_literal: true

class CreateTickerResults < ActiveRecord::Migration[7.1]
  def change
    create_table :ticker_results do |t|
      t.references :ticker, null: false, foreign_key: true
      t.decimal :close_price, null: false
      t.decimal :highest_price, null: false
      t.decimal :lowest_price, null: false
      t.integer :transactions_number, null: false
      t.decimal :open_price, null: false
      t.boolean :otc, null: false, default: false
      t.datetime :aggregate_window_start_at, null: false
      t.decimal :trading_volume, null: false
      t.decimal :volume_weighted_average_price, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
