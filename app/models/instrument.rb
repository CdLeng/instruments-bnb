class Instrument < ApplicationRecord
  belongs_to :instrument_category
  belongs_to :user
  has_many :bookings
end
