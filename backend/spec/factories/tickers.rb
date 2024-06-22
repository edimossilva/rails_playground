# frozen_string_literal: true

# == Schema Information
#
# Table name: tickers
#
#  id             :bigint           not null, primary key
#  average_price  :decimal(, )      not null
#  average_volume :decimal(, )      not null
#  deleted_at     :datetime
#  input_params   :jsonb            not null
#  maximum_price  :decimal(, )      not null
#  maximum_volume :decimal(, )      not null
#  minimum_price  :decimal(, )      not null
#  minimum_volume :decimal(, )      not null
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :ticker do
    name { "AAPL" }
    input_params { { name: "AAPL", from_date: "2023-01-01", to_date: "2023-12-31" } }
    maximum_price { 150.0 }
    minimum_price { 130.0 }
    average_price { 140.0 }
    maximum_volume { 100_000.0 }
    minimum_volume { 50_000.0 }
    average_volume { 75_000.0 }

    trait :without_calculated_fields do
      maximum_price { nil }
      minimum_price { nil }
      average_price { nil }
      maximum_volume { nil }
      minimum_volume { nil }
      average_volume { nil }
    end
  end
end
