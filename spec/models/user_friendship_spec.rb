require 'rails_helper'

RSpec.describe UserFriendship, type: :model do
  
  describe 'Validations' do 
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :friend_id }
    it { should validate_presence_of :status }
    it { should allow_values('requested', 'confirmed', 'declined', 'cancelled').for :status }
  end
  describe 'Associations' do
    it { should belong_to :requestor }
    it { should belong_to :friend }
  end
end
