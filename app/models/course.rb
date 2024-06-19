class Course < ApplicationRecord
  has_one_attached :image
  enum status: { construction: 0, active: 1, inactive: 2 }
  validates :title, presence: true
  validates :description, presence: true
  # validates :status, numericality: { only_integer: true }

  belongs_to :user, default: -> { Current.user }
  has_many :enrollments
  has_many :consumers, through: :enrollments, source: :user

  before_validation :set_default_user, on: :create

  def change_status(new_status)
    update(status: new_status)
  end

  def creator
    user
  end

  def consumer_enrolled?(user)
    enrollments.exists?(user_id: user.id)
  end

  private

  def set_default_user
    self.user ||= Current.user
  end
end
