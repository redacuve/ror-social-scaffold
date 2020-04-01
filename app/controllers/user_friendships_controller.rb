class UserFriendshipsController < ApplicationController
  before_action :set_userfriendship, only: [:show, :edit, :update, :destroy]

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

  def edit; end

  def update
    if @user_friendship.update(status: params[:status])
      flash[:notice] = 'You responded to this invitation'
    else
      flash[:alert] = 'You cannot respond to this invitation right now please try again later'
    end
    redirect_to current_user
  end

  private

  def set_userfriendship
    @user_friendship = UserFriendship.find(params[:id])
  end

  def user_friendship_params
    params.require(:user_friendship).permit(:user_id, :friend_id, :status)
  end
end
