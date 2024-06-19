class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :courses, dependent: :destroy

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course

  def admin?
    roles.exists?(name: 'admin')
  end

  def creator?
    roles.exists?(name: 'creator')
  end

  def consumer?
    roles.exists?(name: 'consumer')
  end

  def enrolled_in_creator_courses?(creator)
    enrolled_courses.any? { |course| course.user == creator }
  end
end
