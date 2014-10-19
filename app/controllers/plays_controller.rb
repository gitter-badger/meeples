class PlaysController < ApplicationController

  before_filter :authenticate_user!, except: %i[ show ]

  load_and_authorize_resource :game
  load_and_authorize_resource :play, shallow: true, :through => :game

  autocomplete :user, :usernames, full: true, :column_name => :username, extra_data: %i[ id ]

  def new
    respond_with @game
  end

  def create
    @play.user = current_user
    usernames = params[:play][:user_usernames].to_a.first.split(',')
    usernames.reject! { |name| name.downcase == current_user.username.downcase }
    @play.player_ids = User.all_by_username(usernames.uniq).select(:id).map(&:id)
    @play.save
    respond_with @play
  end

  def show
    respond_with @play
  end

private

  def play_params
    params.require(:play).permit :description, user_usernames: [ ]
  end

end
