# frozen_string_literal: true

module TickerContracts
  class Index < ApplicationContract
    params do
      required(:ticker_name).filled(:string)
      optional(:from_date).filled(:string)
      optional(:to_date).filled(:string)
    end
  end
end
