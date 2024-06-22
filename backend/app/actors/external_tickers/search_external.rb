# frozen_string_literal: true

module ExternalTickers
  class SearchExternal < Actor
    input :ticker_index_contract

    output :external_ticker

    def call
      self.external_ticker = search_external_ticker(ticker_index_contract:)
    end

    private

    def search_external_ticker(ticker_index_contract:)
      tickers_url = PolygonUrlProvider.tickers_url(ticker_index_contract:)
      response = HTTParty.get(tickers_url)
      if response.success?
        JSON.parse(response.body)
      else
        fail!(error: { message: response.body, code: response.code })
      end
    end
  end
end
