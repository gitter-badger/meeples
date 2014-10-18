class PlaysController < ApplicationController

  before_filter :authenticate_user!

  load_and_authorize_resource :game
  load_and_authorize_resource :play, shallow: true, :through => :game

  def new
    respond_with @game
  end

  def create
    @play.user = current_user
    @play.save
    respond_with @play
  end

  def show
    respond_with @play
  end

private

  def play_params
    params.require(:play).permit :description
  end

end
