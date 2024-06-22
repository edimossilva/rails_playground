# frozen_string_literal: true

module Api
  module V1
    class TickersController < Api::V1::ApiController
      skip_before_action :authenticate_devise_api_token!, only: :index
      skip_after_action :verify_authorized

      def index
        external_tickers_result = ExternalTickers::SearchExternal.result(ticker_index_contract:)

        if external_tickers_result.success?
          render json: external_tickers_result.external_tickers, status: :ok
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
