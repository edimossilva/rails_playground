# frozen_string_literal: true

module ExternalTickers
  class CalculateMetrics < Actor
    input :ticker

    output :ticker_with_metrics

    def call
      dup_ticker_results = ticker.ticker_results.map(&:dup)
      dup_ticker = ticker.dup
      dup_ticker.ticker_results = dup_ticker_results
      self.ticker_with_metrics = calculate_metrics(ticker: dup_ticker)
    end

    private

    def calculate_metrics(ticker:)
      maximum_price = 0
      minimum_price = ticker.ticker_results[0]&.lowest_price
      close_prices = []
      maximum_volume = 0
      minimum_volume = ticker.ticker_results[0]&.volume_weighted_average_price
      volumes = []

      ticker.ticker_results.each do |ticker_result|
        maximum_price = ticker_result.highest_price if ticker_result.highest_price > maximum_price
        minimum_price = ticker_result.lowest_price if ticker_result.lowest_price < minimum_price
        close_prices.push(ticker_result.close_price)

        if ticker_result.volume_weighted_average_price > maximum_volume
          maximum_volume = ticker_result.volume_weighted_average_price
        end
        if ticker_result.volume_weighted_average_price < minimum_volume
          minimum_volume = ticker_result.volume_weighted_average_price
        end
        volumes.push(ticker_result.volume_weighted_average_price)
      end

      ticker.maximum_price = maximum_price
      ticker.minimum_price = minimum_price
      ticker.average_price = close_prices.sum / close_prices.count

      ticker.maximum_volume = maximum_volume
      ticker.minimum_volume = minimum_volume
      ticker.average_volume = volumes.sum / volumes.count

      ticker
    end
  end
end
