class GamesController < InheritedResources::Base

  respond_to :html

  def index
    @games = if params[:search]
      Game.search_by_name params[:search][:game_name]
    else
      Game.all
    end

    params[:search] ||= {}
    respond_with @games
  end

end
