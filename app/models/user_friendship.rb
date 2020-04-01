class UserFriendship < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :status, presence: true, acceptance: { accept: %w[requested confirmed declined cancelled] }

  belongs_to :requestor, class_name: 'User', foreign_key: 'user_id'
  belongs_to :friend, class_name: 'User'

  scope :with_status, ->(status) { where 'status = ?', status }
  scope :to_user, ->(user_id) { where 'friend_id = ?', user_id }
  scope :from_user, ->(user_id) { where 'user_id = ?', user_id }
end
