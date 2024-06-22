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
              "v" => 201_218_104,
              "vw" => 126.133,
              "o" => 130.28,
              "c" => 126.36,
              "h" => 130.9,
              "l" => 124.17,
              "t" => 1_672_722_000_000,
              "n" => 1_791_107
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
        expect(result.ticker).to_not be_persisted
      end

      it "returns ticker_results" do
        expect(result.ticker.ticker_results).to_not eq([])
      end
    end
  end
end
