class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_friendships, -> { where status: 'confirmed' }
  has_many :friends, through: :user_friendships, source: 'friendship'

#  scope :friends, -> { where(user_frienships: { status: 'confirmed' } ) }

  
end
