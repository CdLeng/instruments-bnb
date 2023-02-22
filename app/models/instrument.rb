class Instrument < ApplicationRecord
  belongs_to :instrument_category
  belongs_to :user
  validates :instrument_type, :price, :name, :address, presence: true
  validates :price, numericality: { only_integer: true }
  validates :description, length: { maximum: 400 }
end
