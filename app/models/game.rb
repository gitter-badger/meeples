class Game < ActiveRecord::Base

  BGG_BASE_URL = 'http://www.boardgamegeek.com'
  BGG_TYPES    = %w[ rpgitem videogame boardgame boardgameexpansion ]

  require 'open-uri'
  require 'nokogiri'

  has_many :plays
  has_many :users, ->{ uniq }, :through => :plays

  validates :name, presence: true

  scope :lookup, ->(n){ where 'lower(name) like ?', "%#{ n.downcase }%" }

  def self.bgg_api_search_url query
    "#{BGG_BASE_URL}/xmlapi2/search?query=#{URI.escape query}"
  end

  def self.played_by user_id
    group('games.id').
    joins(:plays).
    order('last_played_at desc').
    select("DISTINCT on (games.id, last_played_at) games.*, count(plays.id) as play_count, min(plays.created_at) as first_played_at, max(plays.created_at) as last_played_at").
    where('plays.user_id = ?', user_id)
  end

  def self.search_by_name game_name
    games = lookup game_name
    search_bgg! game_name unless games.any?
    games ||= lookup game_name
  end

  def bgg_link
    return unless bgg_type
    "#{BGG_BASE_URL}/#{bgg_type}/#{bgg_id}/#{URI.encode name}"
  end

  def stack_exchange_link
    "http://boardgames.stackexchange.com/search?q=#{name}"
  end

private

  def self.search_bgg! query
    url = bgg_api_search_url query
    doc = Nokogiri::HTML open(url), nil, 'utf-8'

    doc.xpath('//item').map do |item|
      id   = item['id']
      type = item['type']
      name = item.css('name').attribute('value').value
      year = item.css('yearpublished').attribute('value').value unless item.css('yearpublished').blank?

      game = where(bgg_id: id, name: name, year_published: year).first_or_initialize
      game.bgg_type = type
      game.save if game.changed?
    end
  end

end
