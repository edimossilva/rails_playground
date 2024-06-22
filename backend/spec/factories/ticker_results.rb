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
FactoryBot.define do
  factory :ticker_result do
    ticker
    close_price { 140.0 }
    highest_price { 145.0 }
    lowest_price { 135.0 }
    transactions_number { 1000 }
    open_price { 138.0 }
    otc { false }
    aggregate_window_start_at { Time.current }
    trading_volume { 80_000.0 }
    volume_weighted_average_price { 139.0 }
  end
end
