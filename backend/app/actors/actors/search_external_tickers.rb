# frozen_string_literal: true

module Actors
  class SearchExternalTickers < Actor
    input :ticker_index_contract

    output :external_tickers

    def call
      self.external_tickers = search_external_tickers(ticker_index_contract:)

      fail!(error: :failed_to_find_tickers) unless external_tickers
    end

    private

    def search_external_tickers(ticker_index_contract:)
      tickers_url = PolygonUrlProvider.tickers_url(ticker_index_contract:)
      response = HTTParty.get(tickers_url)
      if response.success?
        response.body
      else
        fail!(error: { message: response.message, code: response.code })
      end
    end
  end
end
