class Play < ActiveRecord::Base

  belongs_to :game
  belongs_to :user

  has_many :comments
  has_many :game_players
  has_many :players,      :through => :game_players, class: User

  validates :game, presence: true
  validates :user, presence: true

  scope :recent, -> { limit 15 }

  attr_accessor :user_usernames

  def self.unique_users
    select('distinct user_id').count
  end

  def self.unique_games
    select('distinct game_id').count
  end

end
