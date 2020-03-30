class UserFriendship < ApplicationRecord
    belongs_to :user
    belongs_to :friendship, class_name: 'User', foreign_key: 'friend_id'
end
