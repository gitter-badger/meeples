class Game < ActiveRecord::Base

  require 'open-uri'
  require 'nokogiri'

  validates :name, presence: true

  scope :lookup, ->(name){ where 'lower(name) like ?', "%#{name}%"}

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
