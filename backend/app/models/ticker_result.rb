# frozen_string_literal: true

# == Schema Information
#
# Table name: ticker_results
#
#  id                            :bigint           not null, primary key
#  aggregate_window_start_at     :datetime         not null
#  close_price                   :decimal(, )      not null
#  deleted_at                    :datetime
#  highest_price                 :decimal(, )      not null
#  lowest_price                  :decimal(, )      not null
#  open_price                    :decimal(, )      not null
#  otc                           :boolean          default(FALSE), not null
#  trading_volume                :decimal(, )      not null
#  transactions_number           :integer          not null
#  volume_weighted_average_price :decimal(, )      not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  ticker_id                     :bigint           not null
#
# Indexes
#
#  index_ticker_results_on_ticker_id  (ticker_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticker_id => tickers.id)
#
class TickerResult < ApplicationRecord
  belongs_to :ticker

  validates :close_price, presence: true
  validates :highest_price, presence: true
  validates :lowest_price, presence: true
  validates :transactions_number, presence: true
  validates :open_price, presence: true
  validates :aggregate_window_start_at, presence: true
  validates :trading_volume, presence: true
  validates :volume_weighted_average_price, presence: true
end
