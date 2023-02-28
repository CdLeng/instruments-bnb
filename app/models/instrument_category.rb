class InstrumentCategory < ApplicationRecord
  validates :category, presence: true
  validates :category, uniqueness: true
  has_many :instruments
end
