class Instrument < ApplicationRecord
  belongs_to :instrument_category
  belongs_to :user
  has_many :bookings
  has_many :reviews
  validates :price, :name, :address, presence: true
  validates :price, numericality: true
  validates :description, length: { maximum: 400 }

  include PgSearch::Model

  pg_search_scope :search_by_name_and_description,
  against: [ :name, :description ],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
  }
end
