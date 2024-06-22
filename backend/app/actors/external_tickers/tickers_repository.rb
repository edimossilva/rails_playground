# frozen_string_literal: true

module ExternalTickers
  class TickersRepository < Actor
    input :ticker

    output :persisted_ticker

    def call
      self.persisted_ticker = persist_ticker(ticker:)
    end

    private

    def persist_ticker(ticker:)
      ticker.save

      ticker
    end
  end
end
