class Course < ApplicationRecord
  has_one_attached :image
  enum status: { construction: 0, active: 1, inactive: 2 }
  validates :title, presence: true
  validates :description, presence: true
  # validates :status, numericality: { only_integer: true }
end
