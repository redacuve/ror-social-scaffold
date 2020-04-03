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

  scope :with_status, ->(status) { where 'user_friendships.status = ?', status }

  # Obtains users and his friends posts icreated date
  def timeline_posts
    friend_list = friends.map(&:id)
    friend_list << id
    Post.where('user_id IN (?)', friend_list).ordered_by_most_recent
  end

  def pending_requests
    requests.with_status('requested')
  end

  def pending_friend?(user_id)
    invitations.to_user(user_id).with_status('requested').exists?
  end

  def pending_request_from?(user_id)
    requests.from_user(user_id).with_status('requested').exists?
  end

  def friends_with?(user_id)
    friendships.where('friend_id = ?', user_id).exists?
  end
end
