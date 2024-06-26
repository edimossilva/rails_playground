# frozen_string_literal: true

module Api
  module V1
    class TickersController < Api::V1::ApiController
      skip_before_action :authenticate_devise_api_token!, only: :index
      skip_after_action :verify_authorized

      def index
        external_tickers_result = ExternalTickers::SearchExternal.result(ticker_index_contract:)
        ticker = ExternalTickers::Parser.result(
          external_ticker: external_tickers_result.external_ticker,
          ticker_index_contract:
        ).ticker
        ticker_with_metrics = ExternalTickers::CalculateMetrics.result(ticker:).ticker_with_metrics
        persisted_ticker = ExternalTickers::TickersRepository.result(ticker: ticker_with_metrics).persisted_ticker
        # TODO: format persisted_tickers on format expected by web_client
        # TODO: move all services above this comment to a single service and check if services nesting works. Only do this after everything is working
        # TODO: add cache based on ticker input_params. This is tricky because if the end_date is after now, cache wont work
        if external_tickers_result.success?
          render json: external_tickers_result.external_ticker, status: :ok
        else
          render json: { error: external_tickers_result.error[:message] }, status: external_tickers_result.error[:code]
        end
      end

      private

      def ticker_index_contract
        @ticker_index_contract ||= TickerContracts::Index.call(permitted_params(:ticker_name, :from_date, :to_date))
      end
    end
  end
end
