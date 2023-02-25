class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :instrument

  # validates :total_price, :date_start, :date_end, presence: true
  # validates :total_price, numericality: true
end
