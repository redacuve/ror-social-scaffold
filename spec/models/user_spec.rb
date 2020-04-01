require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) do
    User.create(id: 1, name: 'example_user', email: 'user@email.com',
                password: '123456', gravatar_url: nil)
  end

  let(:user2) do
    User.create(id: 2, name: 'example_user_2', email: 'user_2@email.com',
                password: '123456', gravatar_url: nil)
  end

  let(:user3) do
    User.new(name: 'example_user_3', email: 'user_3@email.com',
             password: '123456', gravatar_url: nil)
  end

  let(:inv) do
    user1.invitations.build(friend_id: user2.id, status: 'requested')
  end

  it 'should be able to create friend invitations' do
    expect { inv.save }.to change { user1.invitations.count }.by(1)
  end

  it 'should be able to receive friend requests' do
    expect { inv.save }.to change { user2.requests.count }.by(1)
  end

  it 'should not increment count of friends when invitation is declined' do
    inv.save
    expect { inv.update(status: 'declined') }.to change { user1.friends.count }.by(0)
  end

  it 'is not valid if there are the same email saved' do
    user = User.new(name: 'Other', email: 'user@email.com')
    expect(user).to_not be_valid
  end

  it 'is not valid without an name' do
    user3.name = ''
    expect(user3).to_not be_valid
  end

  it 'is not valid with name biger than 20 characters' do
    user3.name = 'a' * 21
    expect(user3).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many :friends }
    it { should have_many :invitations }
    it { should have_many :requests }
  end
end
