class Review < ApplicationRecord
  belongs_to :user
  belongs_to :instrument

  validates :rate, presence: true
  validates :rate, numericality: { only_integer: true }
  validates :content, length: { maximum: 400 }
end
