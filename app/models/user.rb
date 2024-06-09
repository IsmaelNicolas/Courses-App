class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles
  has_many :roles, through: :user_roles

  def admin?
    roles.exists?(name: 'admin')
  end

  def creator?
    roles.exists?(name: 'creator')
  end

  def consumer?
    roles.exists?(name: 'consumer')
  end
end
