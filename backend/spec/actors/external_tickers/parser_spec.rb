# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExternalTickers::Parser, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(external_ticker:, ticker_index_contract:) }

    context "when external_ticker is valid" do
      let(:external_ticker) do
        {
          "ticker" => "AAPL",
          "queryCount" => 21,
          "resultsCount" => 12,
          "adjusted" => true,
          "results" => [
            {
              "c" => 126.36, # close_price
              "h" => 130.9, # highest_price
              "l" => 124.17, # lowest_price
              "n" => 1_791_107, # transactions_number
              "o" => 130.28, # open_price
              "t" => 1_672_722_000_000, # aggregate_window_start_at
              "v" => 201_218_104, # trading_volume
              "vw" => 126.133 # volume_weighted_average_price
            }
          ]
        }
      end
      let(:ticker_index_contract) { TickerContracts::Index.call(ticker_index_params) }
      let(:ticker_index_params) do
        {
          ticker_name: "AAPL"
        }
      end

      it { expect(result.success?).to be true }

      it "returns ticker with proper fields" do
        expect(result.ticker.name).to eq("AAPL")
        expect(result.ticker.input_params).to eq(ticker_index_params.with_indifferent_access)
      end

      it "returns not persisted ticker" do
        expect(result.ticker).not_to be_persisted
      end

      it "returns ticker_results" do
        ticker_result = result.ticker.ticker_results[0]
        expect(ticker_result.close_price).to eq(126.36)
        expect(ticker_result.highest_price).to eq(130.9)
        expect(ticker_result.lowest_price).to eq(124.17)
        expect(ticker_result.transactions_number).to eq(1_791_107)
        expect(ticker_result.open_price).to eq(130.28)
        expect(ticker_result.aggregate_window_start_at.to_time.to_i * 1000).to eq(1_672_722_000_000)
        expect(ticker_result.trading_volume).to eq(201_218_104)
        expect(ticker_result.volume_weighted_average_price).to eq(126.133)
      end
    end
  end
end
