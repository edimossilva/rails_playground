# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExternalTickers::SearchExternal, type: :actor do
  describe ".call" do
    let(:result) { described_class.result(ticker_index_contract:) }

    let(:ticker_index_contract) { TickerContracts::Index.call(ticker_index_params) }
    let(:ticker_index_params) do
      {
        ticker_name: "AAPL"
      }
    end
    let(:tickers_url) { "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2023-01-01/2023-12-31?apiKey=taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx" }

    before do
      allow(HTTParty).to receive(:get).with(tickers_url).and_return(httparty_response)
    end

    context "when response is a success" do
      let(:httparty_response) { instance_double(HTTParty::Response, body: response_body, code: 200, success?: true) }
      let(:response_body) do
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

      context "when from_date and to_date are not sent" do
        it { expect(result.success?).to be true }

        it "returns response body" do
          expect(result.external_tickers).to eq(response_body)
        end
      end

      context "when from_date and to_date are sent they are used at tickers_url" do
        let(:ticker_index_params) do
          {
            ticker_name: "AAPL",
            from_date: "2023-02-01",
            to_date: "2023-11-31"
          }
        end
        let(:tickers_url) { "https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2023-02-01/2023-11-31?apiKey=taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx" }

        it { expect(result.success?).to be true }
      end
    end

    context "when response is a failure" do
      let(:httparty_response) { instance_double(HTTParty::Response, body:, code:, success?: false) }
      let(:response_body) { {} }
      let(:body) { "something wrong" }
      let(:code) { 404 }

      it { expect(result.success?).to be false }

      it "returns error message" do
        expect(result.error[:message]).to eq(body)
      end

      it "returns error code" do
        expect(result.error[:code]).to eq(code)
      end
    end
  end
end
