class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      redirect_to users_url, notice: 'Added Friend'
    else
      redirect_to users_url, error: 'Unable to add friend'
    end
  end

  def index
    @friends = current_user.friends
  end

end
