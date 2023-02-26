class Instrument < ApplicationRecord
  belongs_to :instrument_category
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews
  validates :price, :name, :address, presence: true
  validates :price, numericality: true
  validates :description, length: { maximum: 400 }
end
