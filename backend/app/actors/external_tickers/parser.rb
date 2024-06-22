# frozen_string_literal: true

module ExternalTickers
  class Parser < Actor
    input :external_ticker
    input :ticker_index_contract

    output :ticker

    def call
      self.ticker = parse_ticker(external_ticker:, ticker_index_contract:)
    end

    private

    def parse_ticker(external_ticker:, ticker_index_contract:)
      name = external_ticker["ticker"]
      input_params = ticker_index_contract.to_hash
      ticker = Ticker.new(name:, input_params:)
      external_ticker.with_indifferent_access["results"].each do |ticket_result|
        ticket_result.new(

        )
      end
      binding.pry
    end
  end
end
