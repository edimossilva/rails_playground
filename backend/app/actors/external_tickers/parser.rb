# frozen_string_literal: true

module ExternalTickers
  class Parser < Actor
    input :external_tickers

    output :ticker

    def call
      self.tickers = parse_ticker(external_ticker:)
    end

    private

    def parse_ticker(external_ticker:); end
  end
end
