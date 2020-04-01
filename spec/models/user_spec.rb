require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(id: 1, name: 'example_user', email: 'user@email.com', 
                            password: '123456', gravatar_url: nil) }
  let(:user2) { User.create(id: 2, name: 'example_user_2', email: 'user_2@email.com', 
                            password: '123456', gravatar_url: nil) }
  let(:inv) { user1.invitations.build(friend_id: user2.id, status:'requested') }

  it 'should be able to create friend invitations' do
    expect { inv.save }.to change { user1.invitations.count }.by(1)
  end

  it 'should be able to receive friend requests' do
    expect { inv.save }.to change { user2.requests.count }.by(1)
  end

  it 'should increment count of friends when invitation is confirmed' do
    inv.save
    expect { inv.update(status: 'confirmed') }.to change { user1.friends.count }.by(1)
  end

  describe 'Associations' do
    it { should have_many :friends }
    it { should have_many :invitations }
    it { should have_many :requests }
  end
end
