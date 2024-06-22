# frozen_string_literal: true

class CreateTickers < ActiveRecord::Migration[7.1]
  def change
    create_table :tickers do |t|
      t.string :name, null: false
      t.jsonb :input_params, null: false, default: {}
      t.decimal :maximum_price, null: false
      t.decimal :minimum_price, null: false
      t.decimal :average_price, null: false
      t.decimal :maximum_volume, null: false
      t.decimal :minimum_volume, null: false
      t.decimal :average_volume, null: false

      t.timestamps
    end
  end
end
