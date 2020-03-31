class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, -> { where status: 'confirmed' }, class_name: 'UserFriendship', foreign_key: 'user_id' 
  has_many :invitations, class_name: 'UserFriendship', foreign_key: 'user_id'
  has_many :requests, class_name: 'UserFriendship', foreign_key: 'friend_id'
  
  has_many :friends, through: :friendships, source: 'friend'
  has_many :invitees, through: :invitations, source: 'friend'
  has_many :requestors, through: :requests, source: 'requestor'

  scope :with_status, ->(status) { where "user_friendships.status = ?", status}
end
