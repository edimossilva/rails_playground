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
class Ticker < ApplicationRecord
  has_many :ticker_results, dependent: :destroy

  validates :name, presence: true
  validates :input_params, presence: true
  validates :maximum_price, presence: true
  validates :minimum_price, presence: true
  validates :average_price, presence: true
  validates :maximum_volume, presence: true
  validates :minimum_volume, presence: true
  validates :average_volume, presence: true
end
