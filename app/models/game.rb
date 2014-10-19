class Game < ActiveRecord::Base

  require 'open-uri'
  require 'nokogiri'

  has_many :plays

  validates :name, presence: true

  scope :lookup, ->(n){ where 'lower(name) like ?', "%#{ n }%" }

  def self.played_by user_id
    group('games.id').
    joins(:plays).
    order('last_played_at desc').
    select("DISTINCT on (games.id, last_played_at) games.*, count(plays.id) as play_count, min(plays.created_at) as first_played_at, max(plays.created_at) as last_played_at").
    where('plays.user_id = ?', user_id)
  end

  def self.search_by_name game_name
    games = lookup game_name
    games = search_bgg! game_name unless games.any?
    games
  end

private

  def self.search_bgg! query
    url = "http://www.boardgamegeek.com/xmlapi/search?search=#{ URI.encode query }"
    doc = Nokogiri::HTML open(url), nil, 'utf-8'

    doc.xpath('//boardgame').map do |boardgame|
      id   = boardgame['objectid']
      name = boardgame.css('name').inner_text
      year = boardgame.css('yearpublished').inner_text

      where(bgg_id: id, name: name, year_published: year).first_or_create
    end
  end

end
