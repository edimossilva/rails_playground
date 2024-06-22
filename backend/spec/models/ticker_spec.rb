# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ticker do
  it { is_expected.to have_many(:ticker_results).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:input_params) }
  it { is_expected.to validate_presence_of(:maximum_price) }
  it { is_expected.to validate_presence_of(:minimum_price) }
  it { is_expected.to validate_presence_of(:average_price) }
  it { is_expected.to validate_presence_of(:maximum_volume) }
  it { is_expected.to validate_presence_of(:minimum_volume) }
  it { is_expected.to validate_presence_of(:average_volume) }
end
