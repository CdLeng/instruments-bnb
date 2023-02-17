class Review < ApplicationRecord
  belongs_to :user
  belongs_to :instrument

  validates :rate, presence: true
  validates :rate, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :content, length: { maximum: 400 }
end
