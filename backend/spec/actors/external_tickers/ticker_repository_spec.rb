# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExternalTickers::TickersRepository, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(ticker:) }

    context "when external_ticker is valid" do
      let(:ticker) { build(:ticker, ticker_results: build_list(:ticker_result, 1)) }

      it { expect(result.success?).to be true }

      it "returns ticker with proper fields" do
        expect(result.persisted_ticker).to be_persisted
      end
    end
  end
end
