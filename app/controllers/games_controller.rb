class GamesController < ApplicationController

  load_resource :game

  def index
    params[:search] ||= {}

    @games = Game.search_by_name params[:search][:game_name] if params[:search][:game_name]
    @games = @games.order('name, year_published').page params[:page]

    respond_with @games
  end

  def new
    @game = Game.new
  end

  def create
    @game.added_by = current_user.id if current_user
    @game.save
    respond_with @game
  end

  def show
    @plays = @game.plays.page params[:page]
    current_user.add_recently_viewed @game if current_user
    respond_with @game
  end

  def recently_viewed
  end

private

  def game_params
    params.require(:game).permit :name, :year_published
  end

end
