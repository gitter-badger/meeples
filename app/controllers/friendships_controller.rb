class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build friend_id: params[:friend_id]

    if @friendship.save
      respond_with @friendship, location: users_url, notice: 'Added Friend'
    else
      respond_with @friendship, location: users_url, error: 'Unable to add friend'
    end
  end

  def index
    @friends = current_user.friends.page params[:page]
  end

end
