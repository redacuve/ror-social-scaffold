class UserFriendship < ApplicationRecord
    belongs_to :requestor, class_name: 'User', foreign_key: 'user_id'
    belongs_to :friend, class_name: 'User'
end
