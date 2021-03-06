class PlaysController < ApplicationController

  before_action :authenticate_user!, except: %i[ index show ]

  load_and_authorize_resource :game
  load_and_authorize_resource :play, shallow: true, :through => :game

  autocomplete :user, :usernames, full: true, :column_name => :username, extra_data: %i[ id ]

  def index
    @plays = Play.order('created_at desc').page params[:page]
  end

  def new
    respond_with @game
  end

  def create
    @play.user = current_user
    @play.save
    respond_with @play
  end

  def show
    @comments = @play.comments
    @comment  = @play.comments.build

    respond_with @play
  end

  def destroy
    @play.destroy

    respond_with @play
  end

private

  def play_params
    params.require(:play).permit :description, :rating, user_usernames: [ ]
  end

end
