# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExternalTickers::Parser, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(external_ticker:) }

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

      it { expect(result.success?).to be true }

      it "returns ticker" do
        expect(result.ticker).to eq(response_body)
      end
    end
  end
end
