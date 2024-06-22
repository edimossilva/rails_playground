# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExternalTickers::CalculateMetrics, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(ticker:) }

    context "when external_ticker is valid" do
      let(:ticker) { build(:ticker, :without_calculated_fields, ticker_results:) }
      let(:ticker_result1) do
        build(
          :ticker_result,
          close_price: 200,
          highest_price: 300,
          lowest_price: 100,
          volume_weighted_average_price: 1000
        )
      end
      let(:ticker_result2) do
        build(
          :ticker_result,
          close_price: 400,
          highest_price: 600,
          lowest_price: 200,
          volume_weighted_average_price: 2000
        )
      end
      let(:ticker_results) { [ticker_result1, ticker_result2] }

      it { expect(result.success?).to be true }

      it "returns ticker with calculated fields" do
        expect(result.ticker.maximum_price).to eq(600.to_f)
        expect(result.ticker.minimum_price).to eq(100.to_f)
        expect(result.ticker.average_price).to eq(300.to_f)

        expect(result.ticker.maximum_volume).to eq(2000.to_f)
        expect(result.ticker.minimum_volume).to eq(1000.to_f)
        expect(result.ticker.average_volume).to eq(1500.to_f)
      end

      it "returns not persisted ticker" do
        expect(result.ticker).not_to be_persisted
      end
    end
  end
end
