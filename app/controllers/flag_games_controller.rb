class FlagGamesController < ApplicationController

  load_and_authorize_resource :game
  load_resource :flag_game, shallow: true

  def new
  end

  def create
    @flag_game.user = current_user
    @flag_game.game = @game
    flash[:success] = "You have flagged #{@game.name}" if @flag_game.save
    respond_with @game
  end

private

  def flag_game_params
    params.require(:flag_game).permit :description
  end

end
