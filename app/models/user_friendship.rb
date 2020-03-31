class UserFriendship < ApplicationRecord
    before_create :check_for_pend_invites

    belongs_to :requestor, class_name: 'User', foreign_key: 'user_id'
    belongs_to :friend, class_name: 'User'

    scope :with_status, ->(status) { where 'status = ?', status }
    scope :to_user, ->(user_id) { where 'friend_id = ?', user_id }
    scope :from_user, ->(user_id) { where 'user_id = ?', user_id }

    def check_for_pend_invites
      puts "Before creating invite: "
      puts UserFriendship.exists?(user_id: friend_id, friend_id: user_id, status: 'requested')    
    end

end
