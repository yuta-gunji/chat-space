class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_many :groups, through: :members
  has_many :members
  has_many :messages
end
