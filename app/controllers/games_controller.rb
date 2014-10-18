class GamesController < ApplicationController

  load_resource :game

  def index
    @games = if params[:search]
      Game.search_by_name params[:search][:game_name]
    else
      Game.all
    end

    params[:search] ||= {}
    respond_with @games
  end

  def show
    respond_with @game
  end

end
