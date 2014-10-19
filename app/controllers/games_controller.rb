class GamesController < ApplicationController

  load_resource :game

  def index
    params[:search] ||= {}

    @games = Game.search_by_name params[:search][:game_name] if params[:search][:game_name]
    @games = @games.order('name, year_published').page params[:page]

    respond_with @games
  end

  def show
    respond_with @game
  end

end
