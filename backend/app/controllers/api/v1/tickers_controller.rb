# frozen_string_literal: true

module Api
  module V1
    class TickersController < Api::V1::ApiController
      skip_before_action :authenticate_devise_api_token!, only: :index
      skip_after_action :verify_authorized

      def index
        result = Actors::SearchExternalTickers.result(ticker_index_contract:)
        if result.success?
          render json: result.external_tickers, status: :ok
        else
          render json: { error: result.error[:message] }, status: result.error[:code]
        end
      end

      private

      def ticker_index_contract
        @ticker_index_contract ||= TickerContracts::Index.call(permitted_params(:ticker_name, :from_date, :to_date))
      end
    end
  end
end
