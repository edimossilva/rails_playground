# frozen_string_literal: true

require "rails_helper"

RSpec.describe TickerResult do
  it { is_expected.to belong_to(:ticker) }

  it { is_expected.to validate_presence_of(:close_price) }
  it { is_expected.to validate_presence_of(:highest_price) }
  it { is_expected.to validate_presence_of(:lowest_price) }
  it { is_expected.to validate_presence_of(:transactions_number) }
  it { is_expected.to validate_presence_of(:open_price) }
  it { is_expected.to validate_presence_of(:aggregate_window_start_at) }
  it { is_expected.to validate_presence_of(:trading_volume) }
  it { is_expected.to validate_presence_of(:volume_weighted_average_price) }
end
