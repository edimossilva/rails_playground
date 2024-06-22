# frozen_string_literal: true

class PolygonUrlProvider
  # TODO: extract to env or settings
  DEFAULT_FROM_DATE = "2023-01-01"
  DEFAULT_TO_DATE = "2023-12-31"
  DEFAULT_RANGE = 1
  TICKERS_INDEX_URL = "https://api.polygon.io/v2/aggs/ticker"
  DEFAULT_TIMESPAN = "day"

  def self.tickers_url(ticker_index_contract:)
    ticker_name = ticker_index_contract[:ticker_name]
    from_date = ticker_index_contract[:from_date] || DEFAULT_FROM_DATE
    to_date = ticker_index_contract[:to_date] || DEFAULT_TO_DATE
    range = DEFAULT_RANGE
    timespan = DEFAULT_TIMESPAN

    # TODO: move to secrets or env
    polygon_api_key = "taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx"
    "#{TICKERS_INDEX_URL}/#{ticker_name}/range/#{range}/#{timespan}/#{from_date}/#{to_date}?apiKey=#{polygon_api_key}"
  end
end
