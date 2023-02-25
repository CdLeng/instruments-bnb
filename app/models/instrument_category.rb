class InstrumentCategory < ApplicationRecord
  INSTRUMENTS = ['Electric guitar', 'Classic guitar', 'Bass', 'Piano', 'Saxophone', 'Drums', 'Violin', 'Trumpet', 'Ukelele', 'Flute']
  validates :category, presence: true
  validates :category, uniqueness: true
  validates :category, inclusion: { in: INSTRUMENTS }
  has_many :instruments
end
