class Course < ApplicationRecord
  has_one_attached :image
  enum status: { construction: 0, active: 1, inactive: 2 }
  validates :title, presence: true
  validates :description, presence: true
  # validates :status, numericality: { only_integer: true }

  belongs_to :user, default: -> { Current.user }

  before_validation :set_default_user, on: :create

  # scope :active_courses, -> { where(status: :active) }

  def change_status(new_status)
    update(status: new_status)
  end

  private

  def set_default_user
    self.user ||= Current.user
  end
end
