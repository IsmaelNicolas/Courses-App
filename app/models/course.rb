class Course < ApplicationRecord
  has_one_attached :image
  enum status: { construction: 0, active: 1, inactive: 2 }
  validates :title, presence: true
  validates :description, presence: true
  # validates :status, numericality: { only_integer: true }

  belongs_to :user, default: -> { Current.user }

  before_validation :set_default_user, on: :create

  private

  def set_default_user
    self.user ||= Current.user
  end
end
