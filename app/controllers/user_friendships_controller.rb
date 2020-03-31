class UserFriendshipsController < ApplicationController
  def index
    @user_friendships = UserFriendship.all
  end

  def new
    @user_friendship = UserFriendship.new
  end

  def create
    @user_friendship = UserFriendship.new(user_friendship_params)
    @user_friendship.status = 'requested'
    if @user_friendship.save
      flash[:notice] = 'Your friend request has been sent'
    else
      flash[:alert] = 'Your request cannot be process, try again later'
    end
    redirect_back fallback_location: users_path
  end

  private

  def set_userfriendship
    @user_friendship = UserFriendship.find(params[:id])
  end

  def user_friendship_params
    params.require(:user_friendship).permit(:user_id, :friend_id, :status)
  end
end
