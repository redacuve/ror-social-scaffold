class UserFriendship < ApplicationRecord
    belongs_to :requestor, class_name: 'User', foreign_key: 'user_id'
    belongs_to :friend, class_name: 'User'

    scope :with_status, ->(status) { where 'status = ?', status }
    scope :to_user, ->(user_id) { where 'friend_id = ?', user_id }
    scope :from_user, ->(user_id) { where 'user_id = ?', user_id }

end
